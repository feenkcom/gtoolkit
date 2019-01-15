pipeline {
    agent any
    stages {
        stage('Load latest commit') {
            when { expression {
                    env.BRANCH_NAME.toString().equals('logging') && (env.TAG_NAME.toString().size() == 0)
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
                    env.BRANCH_NAME.toString().equals('logging') && (env.TAG_NAME.toString().startsWith("v"))
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
    }
}