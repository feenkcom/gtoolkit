pipeline {
    agent any
    when { branch 'logging' }
    stages {
        stage('Load') {
            steps {
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
                sh './pharo Pharo.image st --quit scripts/build/runreleaser.st'
            }
        }
    }
}