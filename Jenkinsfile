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
        choice(name: 'BUMP', choices: ['patch', 'minor', 'major'], description: 'What to bump when releasing')
        booleanParam(name: 'RUN_TESTS', defaultValue: true, description: 'Build GT without running tests') }
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

        GEMSTONE_TARGET = 'GemStone-3.7.0'

        RELEASER_FOLDER = 'gt-releaser'
        GTOOLKIT_FOLDER = 'glamoroustoolkit'
        EXAMPLES_FOLDER = 'gt-examples'

        TEST_OPTIONS = '--disable-deprecation-rewrites --skip-packages "Sparta-Cairo" "Sparta-Skia" "GToolkit-RemoteExamples-GemStone"'

        TENTATIVE_PACKAGE_WITHOUT_GT_WORLD = 'GlamorousToolkit-image-without-world.zip'
        TENTATIVE_PACKAGE = 'GlamorousToolkit-tentative.zip'
        RELEASE_PACKAGE_TEMPLATE = 'GlamorousToolkit-{{os}}-{{arch}}-v{{version}}.zip'
        PHARO_IMAGE_URL = 'https://dl.feenk.com/pharo/Pharo9.0-SNAPSHOT.build.1532.sha.e58ef49.arch.64bit.zip'
    }
    stages {
        stage ('Read tool versions') {
            agent {
                label "${MACOS_M1_TARGET}"
            }
            steps {
                script {
                    FEENK_RELEASER_VERSION = sh (
                        script: "cat feenk-releaser.version",
                        returnStdout: true
                    ).trim()
                    GTOOLKIT_BUILDER_VERSION = sh (
                        script: "cat gtoolkit-builder.version",
                        returnStdout: true
                    ).trim()
                }
                echo "Will install using gtoolkit-installer ${GTOOLKIT_BUILDER_VERSION}"
                echo "Will release using feenk-releaser ${FEENK_RELEASER_VERSION}"
                echo "Will run tests: ${env.RUN_TESTS}"
            }
        }
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
                        sh """
                            if [ -d "${EXAMPLES_FOLDER}" ]
                            then
                                echo "Granting write permission for cleanup: ${EXAMPLES_FOLDER}"
                                chmod -R u+w "${EXAMPLES_FOLDER}"
                            fi
                            rm -rf "${EXAMPLES_FOLDER}"
                        """
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

                        sh "curl -o gt-installer -LsS https://github.com/feenkcom/gtoolkit-maestro-rs/releases/download/${GTOOLKIT_BUILDER_VERSION}/gt-installer-${TARGET}"
                        sh 'chmod +x gt-installer'

                        /// the following loads glamorous toolkit without opening GT world
                        sshagent(credentials : ['jenkins-ubuntu-node-aliaksei-syrel']) {
                            sh """
                                ./gt-installer \
                                    --verbose \
                                    --workspace ${RELEASER_FOLDER} \
                                    release-build \
                                        --loader cloner \
                                        --image-url ${PHARO_IMAGE_URL} \
                                        --bump ${params.BUMP} \
                                        --no-gt-world """
                        }

                        script {
                            def newCommitFiles = findFiles(glob: 'gt-releaser/newcommits*.txt')
                            for (int i = 0; i < newCommitFiles.size(); ++i) {
                                env.NEWCOMMITS = readFile(newCommitFiles[i].path)
                                slackSend (color: '#00FF00', message: "Commits from <${env.BUILD_URL}|${env.JOB_NAME} [${env.BUILD_NUMBER}]>:\n ${env.NEWCOMMITS}" )
                            }
                        }
                    }
                }
                stage ('Read gtoolkit version') {
                    when {
                        expression {
                            (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('main')
                        }
                    }
                    steps {
                        script {
                            GT4GEMSTONE_COMMIT_HASH = sh (
                                script: "cd ${RELEASER_FOLDER}/pharo-local/iceberg/feenkcom/gt4gemstone && git rev-parse HEAD",
                                returnStdout: true
                            ).trim()
                        }
                        script {
                            GTOOLKIT_REMOTE_COMMIT_HASH = sh (
                                script: "cd ${RELEASER_FOLDER}/pharo-local/iceberg/feenkcom/gtoolkit-remote && git rev-parse HEAD",
                                returnStdout: true
                            ).trim()
                        }
                        script {
                            GTOOLKIT_EXPECTED_VERSION = sh (
                                script: "./gt-installer --workspace ${RELEASER_FOLDER} print-gtoolkit-image-version",
                                returnStdout: true
                            ).trim()
                        }
                        echo "We expect to release gtoolkit ${GTOOLKIT_EXPECTED_VERSION}"
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

                        /// open gt world
                        sh "./gt-installer --verbose start"

                        /// package with gt-world opened, ready to run tests
                        sh "./gt-installer --verbose package-tentative ${TENTATIVE_PACKAGE}"

                        stash includes: "${TENTATIVE_PACKAGE_WITHOUT_GT_WORLD}", name: "${TENTATIVE_PACKAGE_WITHOUT_GT_WORLD}"
                        stash includes: "${TENTATIVE_PACKAGE}", name: "${TENTATIVE_PACKAGE}"
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

                        GEMSTONE_WORKSPACE="${WORKSPACE}/${EXAMPLES_FOLDER}/remote-gemstone"
                        GT4GEMSTONE_VERSION="${GTOOLKIT_EXPECTED_VERSION}"
                        RELEASED_PACKAGE_GEMSTONE_NAME="gt4gemstone-3.7.0-${GTOOLKIT_EXPECTED_VERSION}"
                    }
                    agent {
                        label "${LINUX_AMD64_TARGET}-${LINUX_SERVER_NAME}"
                    }
                    stages {
                        stage('Clean up') {
                            steps {
                                sh "rm -rf ${GTOOLKIT_FOLDER}"
                                sh """
                                    if [ -d ${EXAMPLES_FOLDER} ]
                                    then
                                        echo "Granting write permission for cleanup: ${EXAMPLES_FOLDER}"
                                        chmod -R u+w ${EXAMPLES_FOLDER}
                                    fi
                                    rm -rf ${EXAMPLES_FOLDER}
                                   """
                                sh 'rm -rf ~/Documents/lepiter'
                                sh 'git clean -fdx'
                                script {
                                    RELEASED_PACKAGE_GEMSTONE = sh (
                                        script: "echo ${RELEASED_PACKAGE_GEMSTONE_NAME}.zip",
                                        returnStdout: true
                                    ).trim()
                                }
                            }
                        }
                        stage('Linux Unpackage') {
                            steps {
                                unstash "${TENTATIVE_PACKAGE}"

                                sh "curl -o gt-installer -LsS https://github.com/feenkcom/gtoolkit-maestro-rs/releases/download/${GTOOLKIT_BUILDER_VERSION}/gt-installer-${TARGET}"
                                sh 'chmod +x gt-installer'

                                sh 'git config --global user.name "Jenkins"'
                                sh 'git config --global user.email "jenkins@feenk.com"'
                                sh "./gt-installer --verbose unpackage-tentative ${TENTATIVE_PACKAGE}"
                            }
                        }
                        stage('Linux Examples') {
                            when { expression {
                                    env.RUN_TESTS
                                }
                            }
                            steps {
                                /// make a copy from GTOOLKIT_FOLDER to the EXAMPLES_FOLDER
                                sh "./gt-installer --verbose copy-to ${EXAMPLES_FOLDER}"

                                sh "xvfb-run -a ./gt-installer --verbose --workspace ${EXAMPLES_FOLDER} test ${TEST_OPTIONS}"
                            }
                        }
                        stage('Linux Remote Examples') {
                            when { expression {
                                    env.RUN_TESTS
                                }
                            }
                            steps {
                                sh 'rm -rf ~/Documents/lepiter'
                                
                                sh """
                                    cd ${EXAMPLES_FOLDER}
                                    git clone https://github.com/feenkcom/gt4gemstone.git 
                                    cd gt4gemstone 
                                    git checkout ${GT4GEMSTONE_COMMIT_HASH}
                                   """
                                
                                sh """
                                    cd ${EXAMPLES_FOLDER}
                                    git clone https://github.com/feenkcom/gtoolkit-remote.git
                                    cd gtoolkit-remote 
                                    git checkout ${GTOOLKIT_REMOTE_COMMIT_HASH}
                                   """

                                sh """
                                    cd ${EXAMPLES_FOLDER}
                                    git clone https://github.com/feenkcom/Sparkle.git
                                   """

                                sh """
                                    cd ${EXAMPLES_FOLDER}
                                    chmod +x gt4gemstone/scripts/*.sh
                                    chmod +x gt4gemstone/scripts/release/*.sh
                                    chmod +x gtoolkit-remote/scripts/*.sh
                                   """
                                
                                // Run the GemStone remote examples.
                                // Relies on the Linux Examples stage configuring EXAMPLES_FOLDER correctly.
                                sh """
                                    cd ${EXAMPLES_FOLDER}
                                    ./gt4gemstone/scripts/jenkins_preconfigure_gemstone.sh
                                    ./gt4gemstone/scripts/run-remote-gemstone-examples.sh
                                   """
                           }
                        }
                        stage('Linux Pharo Tests') {
                            when { expression {
                                    env.RUN_TESTS && false
                                }
                            }
                            steps {
                                sh """
                                    cd ${EXAMPLES_FOLDER}
                                    bin/GlamorousToolkit-cli GlamorousToolkit.image test --junit-xml-output 'Zinc.*' 'Zodiac.*'
                                   """
                            }
                        }
                        stage('Linux Report Examples') {
                           when { expression {
                                    env.RUN_TESTS
                                }
                            }
                           steps {
                                junit "${EXAMPLES_FOLDER}/*.xml"
                           }
                        }
                        stage('Linux Package') {
                            when {
                                expression {
                                    (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('main')
                                }
                            }
                            steps {
                                script {
                                    RELEASED_PACKAGE_LINUX = sh (
                                        script: "./gt-installer --verbose package-release ${RELEASE_PACKAGE_TEMPLATE}",
                                        returnStdout: true
                                    ).trim()
                                }
                                echo "Created release package ${RELEASED_PACKAGE_LINUX}"
                            }
                        }
                        stage('Linux Stash') {
                            when {
                                expression {
                                    (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('main')
                                }
                            }
                            steps {
                                echo "About to stash ${RELEASED_PACKAGE_LINUX}"
                                stash includes: "${RELEASED_PACKAGE_LINUX}", name: "${TARGET}"
                            }
                        }
                        stage('GemStone Stash') {
                            when {
                                expression {
                                    env.RUN_TESTS && (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('main')
                                }
                            }
                            steps {
                                sh "cp ${GEMSTONE_WORKSPACE}/${RELEASED_PACKAGE_GEMSTONE} ${WORKSPACE}" 
                                echo "About to stash ${RELEASED_PACKAGE_GEMSTONE}"
                                stash includes: "${RELEASED_PACKAGE_GEMSTONE}", name: "${GEMSTONE_TARGET}"
                            }
                        }
                    }
                }
                stage ('MacOS M1') {
                    environment {
                        TARGET = "${MACOS_M1_TARGET}"
                        CERT = credentials('devcertificate')
                        APPLEPASSWORD = credentials('notarizepassword-manager')
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
                        stage('MacOS M1 Unpackage') {
                            steps {
                                unstash "${TENTATIVE_PACKAGE}"
                                sh "curl -o gt-installer -LsS https://github.com/feenkcom/gtoolkit-maestro-rs/releases/download/${GTOOLKIT_BUILDER_VERSION}/gt-installer-${TARGET}"
                                sh 'chmod +x gt-installer'

                                sh 'git config --global user.name "Jenkins"'
                                sh 'git config --global user.email "jenkins@feenk.com"'
                                sh "./gt-installer --verbose unpackage-tentative ${TENTATIVE_PACKAGE}"
                            }
                        }
                        stage('MacOS M1 Examples') {
                            when { expression {
                                    env.RUN_TESTS
                                }
                            }
                            steps {
                                /// make a copy from GTOOLKIT_FOLDER to the EXAMPLES_FOLDER
                                sh "./gt-installer --verbose copy-to ${EXAMPLES_FOLDER}"

/* Disable M1 Examples due to repeated VM crashes
                                sh "./gt-installer --verbose --workspace ${EXAMPLES_FOLDER} test ${TEST_OPTIONS}"
                                junit "${EXAMPLES_FOLDER}/*.xml"
*/
                            }
                        }
                        stage('MacOS M1 Package') {
                            when {
                                expression {
                                    (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('main')
                                }
                            }
                            steps {
                                script {
                                    RELEASED_PACKAGE_MACOS_M1 = sh (
                                        script: "./gt-installer --verbose package-release ${RELEASE_PACKAGE_TEMPLATE}",
                                        returnStdout: true
                                    ).trim()
                                }
                                echo "Created release package ${RELEASED_PACKAGE_MACOS_M1}"
                            }
                        }
                        stage('MacOS M1 Notarize') {
                            when {
                                expression {
                                    (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('main')
                                }
                            }
                            steps {
                                sh """
                                xcrun altool \
                                    -t osx \
                                    -f ${RELEASED_PACKAGE_MACOS_M1} \
                                    -itc_provider "77664ZXL29" \
                                    --primary-bundle-id "com.feenk.gtoolkit.darwin-apple-aarch64" \
                                    --notarize-app \
                                    --verbose \
                                    --username "notarization@feenk.com" \
                                    --password "${APPLEPASSWORD}" \
                                """
                            }
                        }
                        stage('MacOS M1 Stash') {
                            when {
                                expression {
                                    (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('main')
                                }
                            }
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
                        APPLEPASSWORD = credentials('notarizepassword-manager')
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
                        stage('MacOS Intel Unpackage') {
                            steps {
                                unstash "${TENTATIVE_PACKAGE}"

                                sh "curl -o gt-installer -LsS https://github.com/feenkcom/gtoolkit-maestro-rs/releases/download/${GTOOLKIT_BUILDER_VERSION}/gt-installer-${TARGET}"
                                sh 'chmod +x gt-installer'

                                sh 'git config --global user.name "Jenkins"'
                                sh 'git config --global user.email "jenkins@feenk.com"'
                                sh "./gt-installer --verbose unpackage-tentative ${TENTATIVE_PACKAGE}"
                            }
                        }
                        stage('MacOS Intel Examples') {
                            when { expression {
                                    env.RUN_TESTS
                                }
                            }
                            steps {
                                /// make a copy from GTOOLKIT_FOLDER to the EXAMPLES_FOLDER
                                sh "./gt-installer --verbose copy-to ${EXAMPLES_FOLDER}"

                                sh "./gt-installer --verbose --workspace ${EXAMPLES_FOLDER} test ${TEST_OPTIONS}"
                                junit "${EXAMPLES_FOLDER}/*.xml"
                            }
                        }
                        stage('MacOS Intel Package') {
                            when {
                                expression {
                                    (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('main')
                                }
                            }
                            steps {
                                script {
                                    RELEASED_PACKAGE_MACOS_INTEL = sh (
                                        script: "./gt-installer --verbose package-release ${RELEASE_PACKAGE_TEMPLATE}",
                                        returnStdout: true
                                    ).trim()
                                }
                                echo "Created release package ${RELEASED_PACKAGE_MACOS_INTEL}"
                            }
                        }
                        stage('MacOS Intel Notarize') {
                            when {
                                expression {
                                    (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('main')
                                }
                            }
                            steps {
                                sh """
                                xcrun altool \
                                    -t osx \
                                    -f ${RELEASED_PACKAGE_MACOS_INTEL} \
                                    -itc_provider "77664ZXL29" \
                                    --primary-bundle-id "com.feenk.gtoolkit.darwin-apple-x86-64" \
                                    --notarize-app \
                                    --verbose \
                                    --username "notarization@feenk.com" \
                                    --password "${APPLEPASSWORD}" \
                                """
                            }
                        }
                        stage('MacOS Intel Stash') {
                            when {
                                expression {
                                    (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('main')
                                }
                            }
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
                        stage('Windows Unpackage') {
                            steps {
                                unstash "${TENTATIVE_PACKAGE}"

                                powershell "curl -o gt-installer.exe https://github.com/feenkcom/gtoolkit-maestro-rs/releases/download/${GTOOLKIT_BUILDER_VERSION}/gt-installer-${TARGET}.exe"

                                powershell 'git config --global user.name "Jenkins"'
                                powershell 'git config --global user.email "jenkins@feenk.com"'
                                powershell "./gt-installer.exe --verbose unpackage-tentative ${TENTATIVE_PACKAGE}"
                            }
                        }
                        stage('Windows Examples') {
                            when { expression {
                                    env.RUN_TESTS
                                }
                            }
                            steps {
                                /// make a copy from GTOOLKIT_FOLDER to the EXAMPLES_FOLDER
                                powershell "./gt-installer.exe --verbose copy-to ${EXAMPLES_FOLDER}"

                                powershell "./gt-installer.exe --verbose --workspace ${EXAMPLES_FOLDER} test ${TEST_OPTIONS}"
                                junit "${EXAMPLES_FOLDER}/*.xml"
                            }
                        }
                        stage('Windows Package') {
                            when {
                                expression {
                                    (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('main')
                                }
                            }
                            steps {
                                script {
                                    RELEASED_PACKAGE_WINDOWS = powershell (
                                        returnStdout: true,
                                        script: "./gt-installer.exe --verbose package-release \"${RELEASE_PACKAGE_TEMPLATE}\"",
                                    ).trim()
                                }
                                echo "Created release package ${RELEASED_PACKAGE_WINDOWS}"
                            }
                        }
                        stage('Windows Stash') {
                            when {
                                expression {
                                    (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME.toString().equals('main')
                                }
                            }
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
                unstash "${GEMSTONE_TARGET}"

                sh "curl -o feenk-releaser -LsS https://github.com/feenkcom/releaser-rs/releases/download/${FEENK_RELEASER_VERSION}/feenk-releaser-${TARGET}"
                sh "chmod +x feenk-releaser"

                sshagent(credentials : ['jenkins-ubuntu-node-aliaksei-syrel']) {
                    sh """
                        ./gt-installer \
                            --verbose \
                            --workspace ${RELEASER_FOLDER} \
                            run-releaser \
                                --bump ${params.BUMP} """
                }

                sh """
                ./feenk-releaser \
                    --owner feenkcom \
                    --repo gtoolkit \
                    --token GITHUB_TOKEN \
                    --version ${GTOOLKIT_EXPECTED_VERSION} \
                    --auto-accept \
                    --assets \
                        ${RELEASED_PACKAGE_LINUX} \
                        ${RELEASED_PACKAGE_MACOS_M1} \
                        ${RELEASED_PACKAGE_MACOS_INTEL} \
                        ${RELEASED_PACKAGE_WINDOWS} \
                        ${TENTATIVE_PACKAGE_WITHOUT_GT_WORLD} \
                        ${RELEASED_PACKAGE_GEMSTONE} """


                sh "chmod +x ./scripts/build/*.sh"

                sshagent(credentials : ['jenkins-ubuntu-node-aliaksei-syrel']) {
                    sh "./scripts/build/upload.sh"
                }

                script {
                    withCredentials([sshUserPrivateKey(credentialsId: '31ee68a9-4d6c-48f3-9769-a2b8b50452b0', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'userName')]) {
                            def remote = [:]
                            remote.name = 'deploy'
                            remote.host = 'sftp.feenk.com'
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
