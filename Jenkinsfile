pipeline {
    agent any
    stages {
        stage('Load latest commit') {
            when { allOf { branch 'logging';  not { tag '.*' } } }
            steps {
                sh 'git clean -f -d'
                sh 'rm -rf pharo-local'
                sh 'scripts/build/load.sh'
            }
        }
        stage('Load latest tag') {
            when { allOf { branch 'logging'; tag '.*' } }
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