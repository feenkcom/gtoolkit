pipeline {
    agent any
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

        // stage('Run releaser') { we run releaser manually for now
        //     steps {
        //         sh 'scripts/build/runreleaser.sh'
        //     }
        // }

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
            }
        }
    }
}