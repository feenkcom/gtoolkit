pipeline {
    agent any
    parameters { string(name: 'FORCED_TAG_NAME', defaultValue: '', description: 'params.FORCED_TAG_NAME env variable') }
    options { 
        buildDiscarder(logRotator(numToKeepStr: '50'))
        disableConcurrentBuilds() 
    }
    environment {
        GITHUB_TOKEN = credentials('githubrelease')
    }
    stages {
        stage('Clean Workspace') {
            steps {
                sh 'git clean -fdx'
                sh 'chmod +x scripts/build/*.sh'
                slackSend (color: '#FFFF00', message: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
            }
        }
        stage('Load latest master commit') {
            when { expression {
                    env.BRANCH_NAME.toString().equals('master')
                }
            }
            steps {
                sh 'git clean -f -d'
                sh 'rm -rf pharo-local'
                sh 'scripts/build/load.sh'
                script {
                    def newCommitFiles = findFiles(glob: 'newcommits*.txt')
                    for (int i = 0; i < newCommitFiles.size(); ++i) {
                        env.NEWCOMMITS = readFile( ${newCommitFiles[i]} )
                        slackSend (color: '#00FF00', message: "Commits to be included in the next build:\n${env.NEWCOMMITS}" )   
                    }
                } 
            }
        }
        stage('Load latest tag') {
            when { expression {
                    env.TAG_NAME != null && env.TAG_NAME.toString().startsWith("v") 
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
                echo env.BRANCH_NAME
                echo env.TAG_NAME
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
    post {
        success {
            slackSend (color: '#00FF00', message: "Successful: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL}) https://dl.feenk.com/gt/gt.jpg" )   
        }

        failure {
            slackSend (color: '#FF0000', message: "Failed: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }

        regression {
            slackSend (color: '#FF0000', message: "Regression: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }

        fixed {
            slackSend (color: '#00FF00', message: "Fixed: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }

        unstable {
            slackSend (color: '#FF0000', message: "Unstable: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
    }
}