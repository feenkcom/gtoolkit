pipeline {
    agent none
    parameters { string(name: 'FORCED_TAG_NAME', defaultValue: '', description: 'params.FORCED_TAG_NAME env variable') }
    options { 
        buildDiscarder(logRotator(numToKeepStr: '50'))
        disableConcurrentBuilds() 
    }
    environment {
        GITHUB_TOKEN = credentials('githubrelease')
        AWSIP = 'ec2-35-157-37-37.eu-central-1.compute.amazonaws.com'
        MASTER_WORKSPACE = ""
    }
    stages {
        stage ('Build pre release') {
            agent {
                label "unix"
            }
            stages {
                stage('Load latest master commit') {
                    when { expression {
                            env.BRANCH_NAME.toString().equals('master')
                        }
                    }
                    steps {
                        script {
                            MASTER_WORKSPACE = WORKSPACE
                        }
                        sh 'git clean -fdx'
                        sh 'chmod +x scripts/build/*.sh'
                        sh 'rm -rf pharo-local/iceberg'
                        
                        slackSend (color: '#FFFF00', message: ("Started <${env.BUILD_URL}|${env.JOB_NAME} [${env.BUILD_NUMBER}]>") )

                        sh 'scripts/build/load.sh'
                        script {
                            def newCommitFiles = findFiles(glob: 'newcommits*.txt')
                            for (int i = 0; i < newCommitFiles.size(); ++i) {
                                env.NEWCOMMITS = readFile(newCommitFiles[i].path)
                                slackSend (color: '#00FF00', message: "Commits from <${env.BUILD_URL}|${env.JOB_NAME} [${env.BUILD_NUMBER}]>:\n ${env.NEWCOMMITS}" )   
                            }
                        } 
                    }
                }
                stage('Package image') {
                    when { expression {
                            env.BRANCH_NAME.toString().equals('master')
                        }
                    }
                    steps {
                        sh 'scripts/build/pack_image.sh'
                        echo currentBuild.toString()
                        echo currentBuild.result
                    }
                }

                stage('Save with GtWorld') {
                    when { expression {
                            (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('master')
                        }
                    }
                    steps {
                        sh 'scripts/build/open_gt_world.sh'
                    }
                }

                stage('Prepare deploy packages') {

                    when {
                        expression {
                            (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('master')
                        }
                    }
                    steps {
                        sh 'scripts/build/package.sh'
                        
                        stash includes: 'GlamorousToolkitWin64*.zip', name: 'winbuild'
                        stash includes: 'lib*.zip', name: 'alllibs'
                        stash includes: 'GT.zip', name: 'gtimage'
                        
                    }
                }

                stage('Upload prerelease') {

                    when {
                        expression {
                            (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('master')
                        }
                    }
                    steps {
                        script {
                            withCredentials([sshUserPrivateKey(credentialsId: '31ee68a9-4d6c-48f3-9769-a2b8b50452b0', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'userName')]) {
                                def remote = [:]
                                remote.name = 'deploy'
                                remote.host = 'ip-172-31-37-111.eu-central-1.compute.internal'
                                remote.user = userName
                                remote.identityFile = identity
                                remote.allowAnyHosts = true
                                sshScript remote: remote, script: "scripts/build/clean-tentative.sh"
                            }
                        }
                        sh 'scripts/build/upload-to-tentative.sh'
                    }
                }
            }
        }
        stage('Run Examples') {
            when { expression {
                   (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('master')
                }
            }
            parallel {
                stage('Linux') {
                    agent {
                        label "unix"
                    }
                     stages {
                        stage('Download') {
                             steps {
                                sh 'chmod +x scripts/build/parallelsmoke/*.sh'
                                sh 'scripts/build/parallelsmoke/lnx_1_download.sh'
                             }
                        }
                        stage('Linux Examples') {
                             steps {
                                retry(3) {
                                    sh 'scripts/build/parallelsmoke/lnx_2_1_examples.sh'
                                    junit '*.xml'
                                }
                             } 
                        }
                        stage('Smoke Test') {
                             steps {
                                sh 'scripts/build/parallelsmoke/lnx_2_2_smoke.sh'
                             }
                        }
                    }
                }
                stage ('MacOSX') {
                    agent {
                        label "macosx"
                    }
                    environment {
                        CERT = credentials('devcertificate')
                        SUDO = credentials('sudo')
                        APPLEPASSWORD = credentials('notarizepassword')
                        SIGNING_IDENTITY = 'Developer ID Application: feenk gmbh (77664ZXL29)'
                    } 
                    stages {
                        stage('Download') {
                             steps {
                                sh 'echo "${SUDO}" | sudo -S git clean -fdx'
                                sh 'chmod +x scripts/build/parallelsmoke/*.sh'
                                sh 'scripts/build/parallelsmoke/osx_1_download.sh'
                             }
                        }
                        stage('MacOSX Examples') {
                             steps {
                                retry(3) {
                                    sh 'scripts/build/parallelsmoke/osx_2_smoke.sh'
                                    sh 'rm -rf GToolkit-Releaser-*.xml'
                                    junit '*.xml'
                                }
                             }
                        }
                        stage('Codesign and Notarize') {
                            when {
                                expression {
                                    (currentBuild.result == null || currentBuild.result == 'SUCCESS')
                                }
                            }
                            steps {
                                sh 'scripts/build/parallelsmoke/osx_3_sign_notarize.sh'

                            }
                        }
                        stage('Upload') {
                            when {
                                expression {
                                    (currentBuild.result == null || currentBuild.result == 'SUCCESS')
                                }
                            }
                             steps {
                                sh 'scripts/build/parallelsmoke/osx_4_upload.sh'
                             }
                        }
                    }
                }
                stage('Windows') {
                    agent {
                        label "windows"
                    }
                    stages {
                        stage('Git clean') {
                             steps {
                                powershell './scripts/build/parallelsmoke/win_1_gitclean.ps1'
                             }
                        }
                        stage('Remove all') {
                             steps {
                                powershell './scripts/build/parallelsmoke/win_2_rmrf.ps1'
                             }
                        }
                        stage('Download') {
                             steps {
                                powershell './scripts/build/parallelsmoke/win_3_download.ps1'
                             }
                        }
                        stage('Unpack') {
                             steps {
                                powershell 'ls'
                                powershell './scripts/build/parallelsmoke/win_3_download.ps1'
                             }
                        }
                        stage('Windows Examples') {
                             steps {
                                retry(3) {
                                    powershell './scripts/build/parallelsmoke/win_5_examples.ps1'
                                    junit '*.xml'
                                }
                             }
                        }
                    }
                }
            }
        }
        stage('Deploy release') {
            agent {
                label "unix"
            }
            when { expression {
                    (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('master')
                }
            }
            steps {
                dir(MASTER_WORKSPACE) {
                    sh 'chmod +x scripts/build/*.sh'
                    
                    unstash 'winbuild'
                    unstash 'alllibs'
                    unstash 'gtimage'  
                    sh 'scripts/build/runreleaser.sh' 
                    sh 'scripts/build/upload.sh'
                    script {
                        TAG_NAME = readFile('tagname.txt').trim()
                        withCredentials([sshUserPrivateKey(credentialsId: '31ee68a9-4d6c-48f3-9769-a2b8b50452b0', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'userName')]) {
                                def remote = [:]
                                remote.name = 'deploy'
                                remote.host = 'ec2-35-157-37-37.eu-central-1.compute.amazonaws.com'
                                remote.user = userName
                                remote.identityFile = identity
                                remote.allowAnyHosts = true
                                sshScript remote: remote, script: "scripts/build/update-latest-links.sh"
                        }
                    }
                }
            }
        }
    }
    post {
        success {
            slackSend (color: '#00FF00', message: "Successful <${env.BUILD_URL}|${env.JOB_NAME} [${env.BUILD_NUMBER}]>" )   
        }

        failure {
            slackSend (color: '#FF0000', message: "Failed  <${env.BUILD_URL}/consoleFull|${env.JOB_NAME} [${env.BUILD_NUMBER}]>")
        }

        unstable {
            slackSend (color: '#FFFF00', message:  "Unstable <${env.BUILD_URL}/testReport|${env.JOB_NAME} [${env.BUILD_NUMBER}]> ")
        }
    }
}