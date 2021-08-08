import hudson.tasks.test.AbstractTestResultAction
import hudson.model.Actionable
import hudson.tasks.junit.CaseResult

@NonCPS
def getFailedTests = { ->
    def testResultAction = currentBuild.rawBuild.getAction(AbstractTestResultAction.class)
    def failedTestsString = "```"

    if (testResultAction != null) {
        def failedTests = testResultAction.getFailedTests()

        if (failedTests.size() > 9) {
            failedTests = failedTests.subList(0, 8)
        }

        for(CaseResult cr : failedTests) {
            failedTestsString = failedTestsString + "${cr.getFullDisplayName()}:\n${cr.getErrorDetails()}\n\n"
        }
        failedTestsString = failedTestsString + "```"
    }
    return failedTestsString
}

@NonCPS
def getTestSummary = { ->
    def testResultAction = currentBuild.rawBuild.getAction(AbstractTestResultAction.class)
    def summary = ""

    if (testResultAction != null) {
        total = testResultAction.getTotalCount()
        failed = testResultAction.getFailCount()

        summary = "Passed: " + (total - failed)
        summary = summary + (", Failed: " + failed)
    } else {
        summary = "No tests found"
    }
    return summary
}

pipeline {
    agent none
    parameters {
        choice(name: 'BUMP', choices: ['patch', 'minor', 'major'], description: 'What to bump when releasing') }
    options {
        buildDiscarder(logRotator(numToKeepStr: '50'))
        disableConcurrentBuilds()
    }
    environment {
        GITHUB_TOKEN = credentials('githubrelease')
        AWSIP = 'sftp.feenk.com'

        MACOS_INTEL_TARGET = 'x86_64-apple-darwin'
        MACOS_M1_TARGET = 'aarch64-apple-darwin'

        LINUX_SERVER_NAME = 'mickey-mouse'
        LINUX_AMD64_TARGET = 'x86_64-unknown-linux-gnu'

        WINDOWS_SERVER_NAME = 'daffy-duck'
        WINDOWS_AMD64_TARGET = 'x86_64-pc-windows-msvc'

        RELEASER_FOLDER = 'gt-releaser'
        GTOOLKIT_FOLDER = 'glamoroustoolkit'
        EXAMPLES_FOLDER = 'gt-examples'

        TEST_OPTIONS = '--disable-deprecation-rewrites --skip-packages "Sparta-Cairo"'

        TENTATIVE_PACKAGE_WITHOUT_GT_WORLD = 'GlamorousToolkit-tentative-without-gt-world.zip'
        RELEASE_PACKAGE_TEMPLATE = 'GlamorousToolkit-{{os}}-{{arch}}-v{{version}}.zip'
        PHARO_IMAGE_URL = 'https://dl.feenk.com/pharo/Pharo9.0-SNAPSHOT.build.1532.sha.e58ef49.arch.64bit.zip'
    }
    stages {
        stage ('Build pre release') {
            environment {
                TARGET = "${MACOS_M1_TARGET}"
            }
            agent {
                label "${MACOS_M1_TARGET}"
            }
            stages {
                stage('Clean up') {
                    steps {
                        sh "rm -rf ${GTOOLKIT_FOLDER}"
                        sh "rm -rf ${RELEASER_FOLDER}"
                        sh "rm -rf ${EXAMPLES_FOLDER}"
                        sh 'rm -rf ~/Documents/lepiter'
                        sh 'git clean -fdx'
                    }
                }
                stage('Load latest commit') {
                    when { expression {
                            env.BRANCH_NAME.toString().equals('main')
                        }
                    }
                    steps {
                        sh 'chmod +x scripts/build/*.sh'

                        slackSend (color: '#FFFF00', message: ("Started <${env.BUILD_URL}|${env.JOB_NAME} [${env.BUILD_NUMBER}]>") )

                        sh "curl -o gt-installer -LsS https://github.com/feenkcom/gtoolkit-maestro-rs/releases/latest/download/gt-installer-${TARGET}"
                        sh 'chmod +x gt-installer'

                        /// the following loads glamorous toolkit without opening GT world
                        sh """
                        ./gt-installer \
                            --verbose \
                            --workspace ${RELEASER_FOLDER} \
                            --image-url ${PHARO_IMAGE_URL} \
                            release-build \
                                --loader metacello \
                                --no-gt-world """

                        script {
                            def newCommitFiles = findFiles(glob: 'glamoroustoolkit/newcommits*.txt')
                            for (int i = 0; i < newCommitFiles.size(); ++i) {
                                env.NEWCOMMITS = readFile(newCommitFiles[i].path)
                                slackSend (color: '#00FF00', message: "Commits from <${env.BUILD_URL}|${env.JOB_NAME} [${env.BUILD_NUMBER}]>:\n ${env.NEWCOMMITS}" )
                            }
                        }
                    }
                }
                stage('Package image') {
                    when {
                        expression {
                            (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('main')
                        }
                    }
                    steps {
                        /// make a copy from RELEASER_FOLDER to the default folder
                        sh "./gt-installer --verbose --workspace ${RELEASER_FOLDER} copy-to"

                        /// clean the ssh keys and remove iceberg repositories
                        sh "./gt-installer --verbose clean-up"

                        /// package without gt-world
                        sh "./gt-installer --verbose package-tentative ${TENTATIVE_PACKAGE_WITHOUT_GT_WORLD}"

                        echo currentBuild.toString()
                        echo currentBuild.result
                        stash includes: "${TENTATIVE_PACKAGE_WITHOUT_GT_WORLD}", name: "${TENTATIVE_PACKAGE_WITHOUT_GT_WORLD}"
                    }
                }

                stage('Upload prerelease') {
                    when {
                        expression {
                            false
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
                   (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('main')
                }
            }
            parallel {
                stage('Linux') {
                    environment {
                        TARGET = "${LINUX_AMD64_TARGET}"
                    }
                    agent {
                        label "${LINUX_AMD64_TARGET}-${LINUX_SERVER_NAME}"
                    }
                    stages {
                        stage('Clean up') {
                            steps {
                                sh "rm -rf ${GTOOLKIT_FOLDER}"
                                sh "rm -rf ${EXAMPLES_FOLDER}"
                                sh 'rm -rf ~/Documents/lepiter'
                                sh 'git clean -fdx'
                            }
                        }
                        stage('Linux Examples') {
                            steps {
                                unstash "${TENTATIVE_PACKAGE_WITHOUT_GT_WORLD}"

                                sh "curl -o gt-installer -LsS https://github.com/feenkcom/gtoolkit-maestro-rs/releases/latest/download/gt-installer-${TARGET}"
                                sh 'chmod +x gt-installer'

                                sh 'git config --global user.name "Jenkins"'
                                sh 'git config --global user.email "jenkins@feenk.com"'
                                sh "./gt-installer --verbose unpackage-tentative ${TENTATIVE_PACKAGE_WITHOUT_GT_WORLD}"

                                /// make a copy from GTOOLKIT_FOLDER to the EXAMPLES_FOLDER
                                sh "./gt-installer --verbose copy-to ${EXAMPLES_FOLDER}"

                                sh "xvfb-run -a ./gt-installer --verbose --workspace ${EXAMPLES_FOLDER} test ${TEST_OPTIONS}"
                                junit "${EXAMPLES_FOLDER}/*.xml"
                            }
                        }
                        stage('Linux Package') {
                            steps {
                                /// open gt world and start the lepiter monitor
                                sh "xvfb-run -a ./gt-installer --verbose start"
                                script {
                                    RELEASED_PACKAGE_LINUX = sh (
                                        script: "./gt-installer --verbose package-release ${RELEASE_PACKAGE_TEMPLATE} --bump ${params.BUMP}",
                                        returnStdout: true
                                    ).trim()
                                }
                                echo "Created release package ${RELEASED_PACKAGE_LINUX}"
                            }
                        }
                        stage('Linux Stash') {
                            steps {
                                echo "About to stash ${RELEASED_PACKAGE_LINUX}"
                                stash includes: "${RELEASED_PACKAGE_LINUX}", name: "${TARGET}"
                            }
                        }
                    }
                }
                stage ('MacOS M1') {
                    environment {
                        TARGET = "${MACOS_M1_TARGET}"
                        CERT = credentials('devcertificate')
                        APPLEPASSWORD = credentials('notarizepassword')
                    }
                    agent {
                        label "${MACOS_M1_TARGET}"
                    }
                    stages {
                        stage('Clean up') {
                            steps {
                                sh "rm -rf ${GTOOLKIT_FOLDER}"
                                sh "rm -rf ${EXAMPLES_FOLDER}"
                                sh 'rm -rf ~/Documents/lepiter'
                            }
                        }
                        stage('MacOS M1 Examples') {
                            steps {
                                unstash "${TENTATIVE_PACKAGE_WITHOUT_GT_WORLD}"

                                sh "curl -o gt-installer -LsS https://github.com/feenkcom/gtoolkit-maestro-rs/releases/latest/download/gt-installer-${TARGET}"
                                sh 'chmod +x gt-installer'

                                sh 'git config --global user.name "Jenkins"'
                                sh 'git config --global user.email "jenkins@feenk.com"'
                                sh "./gt-installer --verbose unpackage-tentative ${TENTATIVE_PACKAGE_WITHOUT_GT_WORLD}"

                                /// make a copy from GTOOLKIT_FOLDER to the EXAMPLES_FOLDER
                                sh "./gt-installer --verbose copy-to ${EXAMPLES_FOLDER}"

                                sh "./gt-installer --verbose --workspace ${EXAMPLES_FOLDER} test ${TEST_OPTIONS}"
                                junit "${EXAMPLES_FOLDER}/*.xml"
                            }
                        }
                        stage('MacOS M1 Package') {
                            steps {
                                /// open gt world and start the lepiter monitor
                                sh "./gt-installer --verbose start"
                                script {
                                    RELEASED_PACKAGE_MACOS_M1 = sh (
                                        script: "./gt-installer --verbose package-release ${RELEASE_PACKAGE_TEMPLATE} --bump ${params.BUMP}",
                                        returnStdout: true
                                    ).trim()
                                }
                                echo "Created release package ${RELEASED_PACKAGE_MACOS_M1}"
                            }
                        }
                        stage('MacOS M1 Notarize') {
                            steps {
                                sh """
                                xcrun altool \
                                    -t osx \
                                    -f ${RELEASED_PACKAGE_MACOS_M1} \
                                    -itc_provider "77664ZXL29" \
                                    --primary-bundle-id "com.feenk.gtoolkit.darwin-apple-aarch64" \
                                    --notarize-app \
                                    --verbose \
                                    --username "george.ganea@feenk.com" \
                                    --password "${APPLEPASSWORD}" \
                                """
                            }
                        }
                        stage('MacOS M1 Stash') {
                            steps {
                                echo "About to stash ${RELEASED_PACKAGE_MACOS_M1}"
                                stash includes: "${RELEASED_PACKAGE_MACOS_M1}", name: "${TARGET}"
                            }
                        }
                    }
                }
                stage ('MacOS Intel') {
                    environment {
                        TARGET = "${MACOS_INTEL_TARGET}"
                        CERT = credentials('devcertificate')
                        APPLEPASSWORD = credentials('notarizepassword')
                    }
                    agent {
                        label "${MACOS_INTEL_TARGET}"
                    }
                    stages {
                        stage('Clean up') {
                            steps {
                                sh "rm -rf ${GTOOLKIT_FOLDER}"
                                sh "rm -rf ${EXAMPLES_FOLDER}"
                                sh 'rm -rf ~/Documents/lepiter'
                                sh 'git clean -fdx'
                            }
                        }
                        stage('MacOS Intel Examples') {
                            steps {
                                unstash "${TENTATIVE_PACKAGE_WITHOUT_GT_WORLD}"

                                sh "curl -o gt-installer -LsS https://github.com/feenkcom/gtoolkit-maestro-rs/releases/latest/download/gt-installer-${TARGET}"
                                sh 'chmod +x gt-installer'

                                sh 'git config --global user.name "Jenkins"'
                                sh 'git config --global user.email "jenkins@feenk.com"'
                                sh "./gt-installer --verbose unpackage-tentative ${TENTATIVE_PACKAGE_WITHOUT_GT_WORLD}"

                                /// make a copy from GTOOLKIT_FOLDER to the EXAMPLES_FOLDER
                                sh "./gt-installer --verbose copy-to ${EXAMPLES_FOLDER}"

                                sh "./gt-installer --verbose --workspace ${EXAMPLES_FOLDER} test ${TEST_OPTIONS}"
                                junit "${EXAMPLES_FOLDER}/*.xml"
                            }
                        }
                        stage('MacOS Intel Package') {
                            steps {
                                /// open gt world and start the lepiter monitor
                                sh "./gt-installer --verbose start"
                                script {
                                    RELEASED_PACKAGE_MACOS_INTEL = sh (
                                        script: "./gt-installer --verbose package-release ${RELEASE_PACKAGE_TEMPLATE} --bump ${params.BUMP}",
                                        returnStdout: true
                                    ).trim()
                                }
                                echo "Created release package ${RELEASED_PACKAGE_MACOS_INTEL}"
                            }
                        }
                        stage('MacOS Intel Notarize') {
                            steps {
                                sh """
                                xcrun altool \
                                    -t osx \
                                    -f ${RELEASED_PACKAGE_MACOS_INTEL} \
                                    -itc_provider "77664ZXL29" \
                                    --primary-bundle-id "com.feenk.gtoolkit.darwin-apple-x86-64" \
                                    --notarize-app \
                                    --verbose \
                                    --username "george.ganea@feenk.com" \
                                    --password "${APPLEPASSWORD}" \
                                """
                            }
                        }
                        stage('MacOS Intel Stash') {
                            steps {
                                echo "About to stash ${RELEASED_PACKAGE_MACOS_INTEL}"
                                stash includes: "${RELEASED_PACKAGE_MACOS_INTEL}", name: "${TARGET}"
                            }
                        }
                    }
                }
                stage('Windows') {
                    agent {
                        label "${WINDOWS_AMD64_TARGET}-${WINDOWS_SERVER_NAME}"
                    }
                    environment {
                        TARGET = "${WINDOWS_AMD64_TARGET}"
                    }
                    stages {
                        stage('Clean up') {
                            steps {
                                powershell "Remove-Item ${GTOOLKIT_FOLDER} -Recurse -ErrorAction Ignore"
                                powershell "Remove-Item ${EXAMPLES_FOLDER} -Recurse -ErrorAction Ignore"
                                powershell 'Remove-Item  "C:/Users/Administrator/Documents/lepiter" -Recurse -ErrorAction Ignore'
                                powershell 'git clean -fdx'
                            }
                        }
                        stage('Windows Examples') {
                            steps {
                                unstash "${TENTATIVE_PACKAGE_WITHOUT_GT_WORLD}"

                                powershell "curl -o gt-installer.exe https://github.com/feenkcom/gtoolkit-maestro-rs/releases/latest/download/gt-installer-${TARGET}.exe"

                                powershell 'git config --global user.name "Jenkins"'
                                powershell 'git config --global user.email "jenkins@feenk.com"'
                                powershell "./gt-installer.exe --verbose unpackage-tentative ${TENTATIVE_PACKAGE_WITHOUT_GT_WORLD}"

                                /// make a copy from GTOOLKIT_FOLDER to the EXAMPLES_FOLDER
                                powershell "./gt-installer.exe --verbose copy-to ${EXAMPLES_FOLDER}"

                                powershell "./gt-installer.exe --verbose --workspace ${EXAMPLES_FOLDER} test ${TEST_OPTIONS}"
                                junit "${EXAMPLES_FOLDER}/*.xml"
                            }
                        }
                        stage('Windows Package') {
                            steps {
                                /// open gt world and start the lepiter monitor
                                powershell "./gt-installer.exe --verbose start"
                                script {
                                    RELEASED_PACKAGE_WINDOWS = powershell (
                                        returnStdout: true,
                                        script: "./gt-installer.exe --verbose package-release \"${RELEASE_PACKAGE_TEMPLATE}\" --bump \"${params.BUMP}\"",
                                    ).trim()
                                }
                                echo "Created release package ${RELEASED_PACKAGE_WINDOWS}"
                            }
                        }
                        stage('Windows Stash') {
                            steps {
                                echo "About to stash ${RELEASED_PACKAGE_WINDOWS}"
                                stash includes: "${RELEASED_PACKAGE_WINDOWS}", name: "${TARGET}"
                            }
                        }
                    }
                }
            }
        }
        stage('Releaser') {
            when { expression {
                   (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('main')
                }
            }
            agent {
                label "${MACOS_M1_TARGET}"
            }
            environment {
                TARGET = "${MACOS_M1_TARGET}"
            }
            steps {
                unstash "${MACOS_INTEL_TARGET}"
                unstash "${MACOS_M1_TARGET}"
                unstash "${LINUX_AMD64_TARGET}"
                unstash "${WINDOWS_AMD64_TARGET}"
                unstash "${TENTATIVE_PACKAGE_WITHOUT_GT_WORLD}"

                sh "curl -o feenk-releaser -LsS https://github.com/feenkcom/releaser-rs/releases/latest/download/feenk-releaser-${TARGET}"
                sh "chmod +x feenk-releaser"

                sh "./gt-installer --verbose --workspace ${RELEASER_FOLDER} run-releaser"

                sh """
                ./feenk-releaser \
                    --owner feenkcom \
                    --repo gtoolkit \
                    --token GITHUB_TOKEN \
                    --bump-${params.BUMP} \
                    --auto-accept \
                    --assets \
                        ${RELEASED_PACKAGE_LINUX} \
                        ${RELEASED_PACKAGE_MACOS_M1} \
                        ${RELEASED_PACKAGE_MACOS_INTEL} \
                        ${RELEASED_PACKAGE_WINDOWS} \
                        ${TENTATIVE_PACKAGE_WITHOUT_GT_WORLD} """
            }
        }
    }
    post {
        success {
            script {
                tsum = getTestSummary()
                slackSend (color: '#00FF00', message: "Successful <${env.BUILD_URL}|${env.JOB_NAME} [${env.BUILD_NUMBER}]>\n$tsum" )
            }
        }

        failure {
            slackSend (color: '#FF0000', message: "Failed  <${env.BUILD_URL}/consoleFull|${env.JOB_NAME} [${env.BUILD_NUMBER}]>")
        }

        unstable {
            script {
                tfailed = getFailedTests()
                tsum = getTestSummary()
                slackSend (color: '#FFFF00', message:  "Unstable <${env.BUILD_URL}/testReport|${env.JOB_NAME} [${env.BUILD_NUMBER}]>\nTest Summary: $tsum\n$tfailed")
            }
        }
    }
}
