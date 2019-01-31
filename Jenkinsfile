pipeline {
    agent any
    parameters { string(name: 'FORCED_TAG_NAME', defaultValue: '', description: 'params.FORCED_TAG_NAME env variable') }
    options { 
        disableConcurrentBuilds() 
    }
    stages {
        stage('Clean Workspace') {
            steps {
                sh 'git clean -fdx'
                sh 'chmod +x scripts/build/*.sh'
            }
        }
        stage('Load latest commit') {
            when { expression {
                    env.BRANCH_NAME.toString().equals('master') && (env.TAG_NAME == null)
                }
            }
            steps {
                sh 'git clean -f -d'
                sh 'rm -rf pharo-local'
                sh 'scripts/build/load.sh'
            }
        }
        stage('Load latest tag') {
            when { expression {
                    env.TAG_NAME.toString().startsWith("v")
                }
            }
            steps {
                sh 'git clean -f -d'
                sh 'rm -rf pharo-local'
                sh 'scripts/build/loadtag.sh'
            }
        }

        stage('Run examples') {
            steps {
                sh 'scripts/build/test.sh'
                junit '*.xml'
            }
        }

        stage('Run releaser') { 
            when { expression {
                    env.BRANCH_NAME.toString().equals('master') && (env.TAG_NAME == null)
                }
            }
            steps {
                sh 'scripts/build/runreleaser.sh'
            }
        }

        stage('Prepare deploy packages') {
            when {
              expression {
                (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.TAG_NAME.toString().startsWith("v")
              }
            }
            steps {
                sh 'scripts/build/package.sh'
            }
        }

        stage('Upload packages') {
            when {
              expression {
                (currentBuild.result == null || currentBuild.result == 'SUCCESS') 
              }
            }
            steps {
                sh 'scripts/build/upload.sh'
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: '31ee68a9-4d6c-48f3-9769-a2b8b50452b0', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'userName')]) {
                        def remote = [:]
                        remote.name = 'deploy'
                        remote.host = 'ip-172-31-37-111.eu-central-1.compute.internal'
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