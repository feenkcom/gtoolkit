pipeline {
    agent any
    stages {
        stage('Load') {
            when { branch 'logging' }
            steps {
                sh 'git clean -f -d'
                sh 'scripts/build/load.sh'
            }
        }
        stage('Run examples') {
            steps {
                sh 'scripts/build/test.sh'
                junit '*.xml'
            }
        }
        stage('Run gtoolkit-releaser') {
            when {
              expression {
                currentBuild.result == null || currentBuild.result == 'UNSTABLE' 
              }
            }
            steps {
                sh 'scripts/build/runreleaser.sh'
            }
        }
    }
}