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
    }
    stages {
        stage ('Build pre release') {
            agent {
                label "unix"
            }
            stages {
                stage('Clean Workspace') {

                    steps {
                        sh 'git clean -fdx -e pharo-local/package-cache'
                        sh 'chmod +x scripts/build/*.sh'
                        // sh 'rm -rf pharo-local/iceberg'
                        slackSend (color: '#FFFF00', message: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
                    }
                }
                stage('Load latest master commit') {
                    when { expression {
                            env.BRANCH_NAME.toString().equals('master')
                        }
                    }
                    steps {
                        sh 'scripts/build/load.sh'
                        script {
                            def newCommitFiles = findFiles(glob: 'newcommits*.txt')
                            for (int i = 0; i < newCommitFiles.size(); ++i) {
                                env.NEWCOMMITS = readFile(newCommitFiles[i].path)
                                slackSend (color: '#00FF00', message: "Commits to be included in the next build:\n ${env.NEWCOMMITS}" )   
                            }
                        } 
                    }
                }
                stage('Run examples') {
                    when { expression {
                            env.BRANCH_NAME.toString().equals('master')
                        }
                    }
                    steps {
                        sh 'scripts/build/test.sh'
                        junit '*.xml'
                        echo currentBuild.toString()
                        echo currentBuild.result
                    }
                }

                stage('Run releaser') { 

                    when { expression {
                            env.BRANCH_NAME.toString().equals('master') && (env.TAG_NAME == null) && (currentBuild.result == null || currentBuild.result == 'SUCCESS')
                        }
                    }
                    steps {
                        sh 'scripts/build/runreleaser.sh'
                    }
                }

                stage('Save Image With GTWorld opened') {
                    when { expression {
                            (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('master')
                        }
                    }
                    steps {
                        sh 'rm -rf pharo-local'
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
                        stash includes: 'GToolkitWin64*.zip', name: 'winbuild'
                        stash includes: 'lib*.zip', name: 'alllibs'
                        stash includes: 'GT.zip', name: 'gtimage'
                        stash includes: 'tagname.txt', name: 'tagname'
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
        stage('Run UI Tests') {
            when { expression {
                   (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('master')
                }
            }
            parallel {
                stage('Test On Linux') {
                    agent {
                        label "unix"
                    }
                     stages {
                        stage('Download') {
                             steps {
                                sh 'git clean -fdx'
                                sh 'chmod +x scripts/build/parallelsmoke/*.sh'
                                sh 'scripts/build/parallelsmoke/lnx_1_download.sh'
                                unstash 'tagname'
                             }
                        }
                        stage('Smoke Test') {
                             steps {
                                sh 'scripts/build/parallelsmoke/lnx_2_smoke.sh'
                                junit '*.xml'
                             }
                        }
                        stage('Upload') {
                             steps {
                                sh 'scripts/build/parallelsmoke/lnx_3_upload.sh'
                             }
                        }
                    }
                }
                stage ('Test Sign and Notarize on MacOSX') {
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
                                sh 'git clean -fdx'
                                sh 'chmod +x scripts/build/parallelsmoke/*.sh'
                                sh 'scripts/build/parallelsmoke/osx_1_download.sh'
                                unstash 'tagname'
                             }
                        }
                        stage('Smoke Test') {
                             steps {
                                sh 'scripts/build/parallelsmoke/osx_2_smoke.sh'
                                junit '*.xml'
                             }
                        }
                        stage('Codesign and Notarize') {
                            steps {
                                sh 'scripts/build/parallelsmoke/osx_3_sign_notarize.sh'

                            }
                        }
                        stage('Upload') {
                             steps {
                                sh 'scripts/build/parallelsmoke/osx_4_upload.sh'
                             }
                        }
                    }
                }
                stage('Test On Windows') {
                    agent {
                        label "windows"
                    }
                    stages {
                        stage('Download') {
                             steps {
                                powershell 'ls'
                                powershell './scripts/build/parallelsmoke/win_1_download.ps1'
                                
                             }
                        }
                        stage('Smoke Test') {
                             steps {
                               powershell './scripts/build/parallelsmoke/win_2_smoke.ps1'
                               junit '*.xml'
                             }
                        }
                        stage('Upload') {
                             steps {
                              powershell 'Write-Output "Linux node will do the windows upload."'
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
                sh 'chmod +x scripts/build/*.sh'
                unstash 'winbuild'
                unstash 'alllibs'
                unstash 'gtimage'
                unstash 'tagname'
                sh 'ls -al'
                sh 'scripts/build/upload.sh'
                script {
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
    post {
        success {
            slackSend (color: '#00FF00', message: "Successful: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' ${env.BUILD_URL} https://dl.feenk.com/gt/gt.jpg" )   
        }

        failure {
            slackSend (color: '#FF0000', message: "Failed: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' ${env.BUILD_URL}consoleFull")
        }

        regression {
            slackSend (color: '#FFFF00', message: "Regression: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' ${env.BUILD_URL}testReport")
        }

        fixed {
            slackSend (color: '#00FF00', message: "Fixed: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' ${env.BUILD_URL}")
        }

        unstable {
            slackSend (color: '#FFFF00', message: "Unstable: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' ${env.BUILD_URL}testReport")
        }
    }
}