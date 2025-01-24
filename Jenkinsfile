import hudson.tasks.test.AbstractTestResultAction
import hudson.model.Actionable
import hudson.tasks.junit.CaseResult

properties([
        parameters([
                choice(name: 'BUMP', choices: ['patch', 'minor', 'major'], description: 'What to bump when releasing'),
                booleanParam(name: 'RUN_TESTS', defaultValue: true, description: 'Run tests during the build')
        ]),
        buildDiscarder(logRotator(numToKeepStr: '50')),
        disableConcurrentBuilds()
])
try {
    onBuildStarted()
    pipeline()
    def currentResult = currentBuild.result ?: 'SUCCESS'
    if (currentResult == 'SUCCESS') {
        postSuccess()
    }
} catch (e) {
    echo "Caught exception: $e; currentBuild.result: ${currentBuild.result}"
    def currentResult = currentBuild.result ?: 'FAILURE'
    if (currentResult == 'FAILURE') {
        postFailure(e)
    }
    // Since we're catching the exception in order to report on it,
    // we need to re-throw it, to ensure that the build is marked as failed
    throw e
} finally {
    def currentResult = currentBuild.result ?: 'SUCCESS'
    if (currentResult == 'UNSTABLE') {
        postUnstable()
    }
}

def pipeline() {
    new GlamorousToolkit(this,
            new Agent(Triplet.MacOS_Aarch64),
            [
                    "BUILD_URL"   : env.BUILD_URL,
                    "JOB_NAME"    : env.JOB_NAME,
                    "BUILD_NUMBER": env.BUILD_NUMBER,
                    "FRESH_BUILD" : true,
                    "CLEAN_UP"    : true
            ] + params).execute()
}

def postSuccess() {
    tsum = getTestSummary()
    slackSend(color: '#00FF00', message: "Successful <${env.BUILD_URL}|${env.JOB_NAME} [${env.BUILD_NUMBER}]>\n$tsum")
}

def postUnstable() {
    tfailed = getFailedTests()
    tsum = getTestSummary()
    slackSend(color: '#FFFF00', message: "Unstable <${env.BUILD_URL}/testReport|${env.JOB_NAME} [${env.BUILD_NUMBER}]>\nTest Summary: $tsum\n$tfailed")
}

def postFailure(e) {
    slackSend(color: '#FF0000', message: "Failed  <${env.BUILD_URL}/consoleFull|${env.JOB_NAME} [${env.BUILD_NUMBER}]> due to $e")
}

def onBuildStarted() {
    slackSend(color: '#FFFF00', message: ("Started <${env.BUILD_URL}|${env.JOB_NAME} [${env.BUILD_NUMBER}]>"))
}

/**
 * An entrance point into the Jenkins build of the Glamorous Toolkit.
 * Knows the build parameters and drives the high level stages of the build.
 * Decides on which Jenkins nodes it should run the build, examples and packaging steps.
 * @see Builder - which is responsible for building a tentative GlamorousToolkit image.
 */
class GlamorousToolkit {
    static final RELEASER_FOLDER = "gt-releaser"
    static final GTOOLKIT_FOLDER = "glamoroustoolkit"
    static final EXAMPLES_FOLDER = "gt-examples"
    static final LEPITER_WINDOWS = "C:/Users/Administrator/Documents/lepiter"
    static final LEPITER_UNIX = "~/Documents/lepiter"
    static final PHARO_IMAGE_URL = "https://dl.feenk.com/pharo/Pharo11-SNAPSHOT.build.726.sha.aece1b5.arch.64bit.zip"
    static final TENTATIVE_PACKAGE_WITHOUT_GT_WORLD = 'GlamorousToolkit-image-without-world.zip'
    static final TENTATIVE_PACKAGE = 'GlamorousToolkit-tentative.zip'
    static final TEST_OPTIONS = '--disable-deprecation-rewrites --skip-packages "GToolkit-Boxer" "Sparta-Cairo" "Sparta-Skia" "GToolkit-RemoteExamples-GemStone" "PythonBridge-Pharo"'
    static final RELEASE_PACKAGE_TEMPLATE = 'GlamorousToolkit-{{os}}-{{arch}}-v{{version}}.zip'
    static final DOCKER_REPOSITORY = 'feenkcom/gtoolkit'
    static final DOCKER_TENTATIVE_TAG = 'tentative'

    final Script script
    Agent agent

    final boolean runTests
    final String bump
    final boolean freshBuild
    final boolean cleanUp

    final String buildUrl
    final String jobName
    final int buildNumber

    String releaserVersion
    String installerVersion
    String gtoolkitVmVersion

    String gtoolkitVersion
    String gt4gemstoneCommitHash
    String gt4remoteCommitHash
    String pythonBridgeCommitHash
    Map<String, String> artefacts

    final ArrayList<AgentJob> jobs

    GlamorousToolkit(Script script, Agent agent, Map params) {
        this.script = script
        this.agent = agent
        this.runTests = params.RUN_TESTS
        this.freshBuild = params.FRESH_BUILD
        this.cleanUp = params.CLEAN_UP
        this.bump = params.BUMP

        this.buildUrl = params.BUILD_URL
        this.jobName = params.JOB_NAME
        this.buildNumber = params.BUILD_NUMBER.toInteger()

        this.gtoolkitVersion = null
        this.gt4gemstoneCommitHash = null
        this.gt4remoteCommitHash = null
        this.pythonBridgeCommitHash = null
        this.artefacts = [:]

        jobs = [
                new TestAndPackage(this, new Agent(Triplet.MacOS_Aarch64), Triplet.MacOS_Aarch64),
                new TestAndPackage(this, new Agent(Triplet.MacOS_X86_64), Triplet.MacOS_X86_64),
                new TestAndPackageWithGemstoneAndPython(this, new Agent(Triplet.Linux_X86_64, "scooby-doo"), Triplet.Linux_X86_64),
                new TestAndPackage(this, new Agent(Triplet.Linux_Aarch64, "peter-pan"), Triplet.Linux_Aarch64),
                new TestAndPackage(this, new Agent(Triplet.Windows_X86_64, "daffy-duck"), Triplet.Windows_X86_64).add_release_target(Triplet.Windows_Aarch64)
        ]
    }

    void execute() {
        script.node(agent.label()) {
            build()
        }

        test_and_package()

        script.node(agent.label()) {
            release()
            releaseDockerImage()
        }
    }

    void build() {
        script.checkout script.scm

        read_tool_versions()
        new Builder(this, agent).execute()
    }

    void test_and_package() {
        def testers = [:]
        for (x in jobs) {
            def job = x
            def shouldPropagate = true
            if (job.agent.getHost() == Triplet.Linux_Aarch64) {
                shouldPropagate = false
            }
            if (job.agent.getHost() == Triplet.MacOS_Aarch64) {
                shouldPropagate = false
            }
            
            // Create a map to pass in to the 'parallel' step so we can fire all the builds at once
            testers[job.agent] = {
                try { job.execute() }
                catch(e) {
                    if (shouldPropagate) { throw e }
                }
            }
        }

        script.parallel testers
    }

    /**
     * Prepare GToolkit Docker images and push them into a Docker hub.
     */
    void releaseDockerImage() {
        def currentResult = script.currentBuild.result ?: 'SUCCESS'
        // we must not release if the build is not successful until this point
        if (currentResult != 'SUCCESS') {
            return;
        }

        script.stage("Docker") {
            doReleaseDockerImage()
        }
    }

    void doReleaseDockerImage() {
        def dockerJobs = [:]

        // platformsArgument is picked from https://hub.docker.com/_/ubuntu, latest tag that we currently use in our Dockerfile
        def jobAMD = new DockerOneArchTentativeImage(this, new Agent(Triplet.Linux_X86_64, "scooby-doo"), Triplet.Linux_X86_64, "linux/amd64")
        def jobARM = new DockerOneArchTentativeImage(this, new Agent(Triplet.Linux_Aarch64, "peter-pan"), Triplet.Linux_Aarch64, "linux/arm64/v8")

        // Create a map to pass in to the 'parallel' step so we can fire all the builds at once
        dockerJobs[jobAMD.agent] = { jobAMD.execute() }
        dockerJobs[jobARM.agent] = { jobARM.execute() }

        script.parallel dockerJobs

        def currentResult = script.currentBuild.result ?: 'SUCCESS'
        // we must not release if the build is not successful until this point
        if (currentResult != 'SUCCESS') {
            return;
        }

        // Publish all manifests as one multi-architecture manifest
        def tentativeImageNames = [jobAMD.tentative_image_name(), jobARM.tentative_image_name() ]
        def multiArchJob = new DockerMultiArchImage(this, new Agent(Triplet.Linux_X86_64, "scooby-doo"), Triplet.Linux_X86_64, tentativeImageNames)

        multiArchJob.execute()
    }

    void release() {
        def currentResult = script.currentBuild.result ?: 'SUCCESS'
        // we must not release if the build is not successful until this point
        if (currentResult != 'SUCCESS') {
            return;
        }

        script.stage("Release") {
            doRelease()
        }
    }

    void doRelease() {
        def artefacts_to_release = ""
        this.artefacts.each {
            key, path ->
                script.unstash "${key}"
                script.echo "Unstashed ${key} as ${path}"
                artefacts_to_release += "${path} "
        }

        // Remove the gt-extra folder so it does not influence the release.
        agent.platform().delete_directory(script, "${RELEASER_FOLDER}/gt-extra")

        download_releaser()

        script.sshagent(credentials: ['jenkins-ubuntu-node-aliaksei-syrel']) {
            agent.platform().exec(
                    script,
                    "./gt-installer",
                    "--verbose " +
                            "--workspace ${RELEASER_FOLDER} " +
                            "run-releaser " +
                            "--bump ${bump}")
        }

        script.withCredentials([script.string(credentialsId: 'githubrelease', variable: 'GITHUB_TOKEN')]) {
            agent.platform().exec(script,
                    "./feenk-releaser",
                    "--owner feenkcom " +
                            "--repo gtoolkit " +
                            "--token GITHUB_TOKEN " +
                            "release " +
                            "--version ${gtoolkitVersion} " +
                            "--auto-accept " +
                            "--assets ${artefacts_to_release}")
        }

        script.sshagent(credentials: ['jenkins-ubuntu-node-aliaksei-syrel']) {
            script.sh "chmod +x ./scripts/build/*.sh"
            script.sh "./scripts/build/upload.sh"
        }

        script.withCredentials([script.sshUserPrivateKey(credentialsId: '31ee68a9-4d6c-48f3-9769-a2b8b50452b0', keyFileVariable: 'REMOTE_IDENTITY_FILE', passphraseVariable: '', usernameVariable: 'REMOTE_USERNAME')]) {
            def remote = [:]
            remote.name = 'deploy'
            remote.host = 'sftp.feenk.com'
            remote.user = script.env.REMOTE_USERNAME
            remote.identityFile = script.env.REMOTE_IDENTITY_FILE
            remote.allowAnyHosts = true
            script.sshScript remote: remote, script: "scripts/build/update-latest-links.sh"
        }
    }

    void stash_for_release(String path, String key = null) {
        this.stash_internally(path, key)
        this.artefacts[key ?: path] = path
    }

    void stash_internally(String path, String key = null) {
        script.echo "About to stash ${path} as ${key ?: path}"
        script.stash includes: path, name: key ?: path
        script.echo "Stashed ${path} as ${key ?: path}"
    }

    /**
     * Reads and remembers versions of the tools used during the build from .version files
     */
    void read_tool_versions() {
        script.stage('Read tool versions') {
            this.releaserVersion = script.sh(
                    script: "cat feenk-releaser.version",
                    returnStdout: true
            ).trim()
            this.installerVersion = script.sh(
                    script: "cat gtoolkit-builder.version",
                    returnStdout: true
            ).trim()
            this.gtoolkitVmVersion = script.sh(
                    script: "cat gtoolkit-vm.version",
                    returnStdout: true
            ).trim()
            script.echo "Will install using gtoolkit-installer ${installerVersion}"
            script.echo "Will release using gtoolkit-vm ${gtoolkitVmVersion}"
            script.echo "Will release using feenk-releaser ${releaserVersion}"
            script.echo "Will run tests: ${runTests}"
        }
    }

    void download_releaser() {
        agent.platform().download_executable(script, releaser_url(), "feenk-releaser")
    }

    String releaser_url() {
        return "https://github.com/feenkcom/releaser-rs/releases/download/${releaserVersion}/feenk-releaser-${agent.host().toString()}"
    }
}

class Builder extends AgentJob {
    Builder(GlamorousToolkit build, Agent agent) {
        super(build, agent)
    }

    @java.lang.Override
    void execute() {
        script.echo "Will build pre-release image on ${agent.label()}"
        cleanUp()
        load_latest_commit()
        read_gtoolkit_versions()
        package_image()
    }

    void load_latest_commit() {
        script.stage('Load latest commit') {
            download_installer()
            build_without_gt_world()
            on_commits_loaded()
        }
    }

    void on_commits_loaded() {
        def newCommitFiles = script.findFiles(glob: 'gt-releaser/newcommits*.txt')
        for (int i = 0; i < newCommitFiles.size(); ++i) {
            def new_commits = script.readFile(newCommitFiles[i].path)
            script.slackSend(color: '#00FF00', message: "Commits from <${script.env.BUILD_URL}|${script.env.JOB_NAME} [${script.env.BUILD_NUMBER}]>:\n ${new_commits}")
        }
    }

    void read_gtoolkit_versions() {
        build.gtoolkitVersion = platform().exec_stdout(script,
                "./gt-installer",
                "--workspace ${GlamorousToolkit.RELEASER_FOLDER} print-gtoolkit-image-version")

        build.gt4gemstoneCommitHash = platform().exec_stdout(script,
                "git",
                "rev-parse HEAD",
                "${GlamorousToolkit.RELEASER_FOLDER}/pharo-local/iceberg/feenkcom/gt4gemstone")

        build.gt4remoteCommitHash = platform().exec_stdout(script,
                "git",
                "rev-parse HEAD",
                "${GlamorousToolkit.RELEASER_FOLDER}/pharo-local/iceberg/feenkcom/gtoolkit-remote")
        
         build.pythonBridgeCommitHash = platform().exec_stdout(script,
                "git",
                "rev-parse HEAD",
                "${GlamorousToolkit.RELEASER_FOLDER}/pharo-local/iceberg/feenkcom/PythonBridge")

        script.echo "We expect to release gtoolkit ${build.gtoolkitVersion}"
        script.echo "We expect to release gt4gemstone ${build.gt4gemstoneCommitHash}"
        script.echo "We expect to release gtoolkit-remote ${build.gt4remoteCommitHash}"

        script.echo "We expect to use PythonBridge ${build.pythonBridgeCommitHash}"
    }

    void build_without_gt_world() {
        if (!build.freshBuild) {
            script.echo "Skipping the loading of the latest commit due to the non-fresh build"
            return
        }
        /// the following loads glamorous toolkit without opening GT world
        script.sshagent(credentials: ['jenkins-ubuntu-node-aliaksei-syrel']) {
            platform().exec(
                    script,
                    "./gt-installer",
                    "--verbose " +
                            "--workspace ${GlamorousToolkit.RELEASER_FOLDER} " +
                             "release-build " +
                            "--app-version ${build.gtoolkitVmVersion} " +
                            "--loader cloner " +
                            "--image-url ${GlamorousToolkit.PHARO_IMAGE_URL} " +
                            "--bump ${build.bump} " +
                            "--no-gt-world")
        }
    }

    void package_image() {
        script.stage('Package image') {
            // make a copy from RELEASER_FOLDER to the default folder
            platform().exec(script, "./gt-installer", "--verbose --workspace ${GlamorousToolkit.RELEASER_FOLDER} copy-to")
            // clean the ssh keys and remove iceberg repositories
            platform().exec(script, "./gt-installer", "--verbose clean-up")
            // package without gt-world
            platform().exec(script, "./gt-installer", "--verbose package-tentative ${GlamorousToolkit.TENTATIVE_PACKAGE_WITHOUT_GT_WORLD}")
            // open gt world
            platform().exec(script, "./gt-installer", "--verbose start")
            // package with gt-world opened, ready to run tests
            platform().exec(script, "./gt-installer", "--verbose package-tentative ${GlamorousToolkit.TENTATIVE_PACKAGE}")

            build.stash_for_release(GlamorousToolkit.TENTATIVE_PACKAGE_WITHOUT_GT_WORLD)
            build.stash_internally(GlamorousToolkit.TENTATIVE_PACKAGE)
        }
    }
}

/**
 * Build and publish a new tentative one-arch image with Glamorous Toolkit of a just released version.
 *
 * Images are published at Docker Hub. See https://hub.docker.com/r/feenkcom/gtoolkit.
 */
class DockerOneArchTentativeImage extends AgentJob {
    final Triplet target

    /**
     * I define platform names that are supposed to build image(s) for.
     * See `docker buildx build --platform` argument for more details.
     */
    final String platformsArgument

    DockerOneArchTentativeImage(GlamorousToolkit build, Agent agent, Triplet target, String platformsArgument) {
        super(build, agent)
        this.target = target
        this.platformsArgument = platformsArgument
    }

    @java.lang.Override
    void execute() {
        script.node(agent.label()) {
            create_and_publish_image()
        }
    }

    /**
     * Return an image tag name that includes repository name and a GToolkit version number.
     * @return docker image tag, e.g., feenkcom/gtoolkit:tentative-x86_64-unknown-linux-gnu
     */
    @NonCPS
    String tentative_image_name() {
        return "${GlamorousToolkit.DOCKER_REPOSITORY}:${GlamorousToolkit.DOCKER_TENTATIVE_TAG}-${target.toString()}".toString()
    }

    /**
     * I use `docker buildx build` to build and publish GToolkit images.
     *
     * Dockerfile and other relevant files are available at scripts/docker/gtoolkit.
     * Those files are packed for Jenkins builds using `gt-installer`, see
     * https://github.com/feenkcom/gtoolkit-maestro-rs/blob/main/src/tools/tentative.rs#L49.
     *
     * I use a `gtoolkit` builder (see the `--builder gtoolkit` argument). The builder was created using
     * on Linux x86-64: `docker buildx create --name gtoolkit --node gtoolkit-amd64 --platform linux/amd64 --bootstrap --use default`
     * on Linux ARM64: `docker buildx create --name gtoolkit --node gtoolkit-arm64 --platform linux/arm64 --bootstrap --use default`
     *
     * Use `docker buildx ls` to list all available builders.
     */
    void create_and_publish_image() {
        // Display docker information (for a debug purpose only)
        platform().exec(script, "docker", "info")
        // Login to the Docker Hub.
        // Note, that the first login in a new machine must happen from a user terminal
        // using `docker login -u feenkcom --password-stdin`. Token can be generated with read and write access
        // at https://hub.docker.com/settings/security.
        platform().exec(script, "docker", "login")
        // Build and publish GToolkit tentative image
        platform().exec(script, "docker", "buildx --builder gtoolkit build --pull --platform ${platformsArgument} --tag ${this.tentative_image_name()} --push glamoroustoolkit".toString())
    }
}

/**
 * Create a new multi-arch image based on source images.
 *
 * Multi-arch image is a collection of images for different platforms (architectures), e.g., Linux x86_64, Linux AMD64.
 * Images are published at Docker Hub. See https://hub.docker.com/r/feenkcom/gtoolkit.
 */
class DockerMultiArchImage extends AgentJob {
    final Triplet target

    /**
     * Source images are strings in a form of feenkcom/gtoolkit:tentative-*,
     * e.g., feenkcom/gtoolkit:tentative-x86_64-unknown-linux-gnu.
     * Those images are created by DockerOneArchTentativeImage.
     */
    final ArrayList<String> sourceImageNames

    DockerMultiArchImage(GlamorousToolkit build, Agent agent, Triplet target, ArrayList<String> sourceImageNames) {
        super(build, agent)
        this.target = target
        this.sourceImageNames = sourceImageNames
    }

    @java.lang.Override
    void execute() {
        script.node(agent.label()) {
            create_multi_arch_images()
        }
    }

    /**
     * Return an image tag name that includes repository name and a GToolkit version number.
     * @return docker image tag, e.g., feenkcom/gtoolkit:v0.8.3085
     */
    String multi_arch_version_name() {
        return "${GlamorousToolkit.DOCKER_REPOSITORY}:${build.gtoolkitVersion}".toString()
    }

    /**
     * Return an image tag name that includes repository name and a latest version name.
     * @return docker image tag in a form feenkcom/gtoolkit:latest
     */
    static String multi_arch_latest_name() {
        return "${GlamorousToolkit.DOCKER_REPOSITORY}:latest".toString()
    }

    /**
     * I create and publish two images, one under the GToolkit version number, and another one under the latest tag.
     */
    void create_multi_arch_images() {
        def amends = this.sourceImageNames.join(" ")
        platform().exec(script, "docker", "buildx imagetools create --tag ${this.multi_arch_version_name()} ${amends}".toString())
        platform().exec(script, "docker", "buildx imagetools create --tag ${multi_arch_latest_name()} ${amends}".toString())
    }
}

class TestAndPackage extends AgentJob {
    final Triplet target
    boolean runTests
    ArrayList<Triplet> extraTargets

    TestAndPackage(GlamorousToolkit build, Agent agent, Triplet target) {
        super(build, agent)
        this.target = target
        this.runTests = build.runTests
        this.extraTargets = []
    }

    @NonCPS
    TestAndPackage disable_tests() {
        this.runTests = false
        return this
    }

    @NonCPS
    TestAndPackage add_release_target(Triplet target) {
        this.extraTargets.add(target)
        return this
    }

    @java.lang.Override
    void execute() {
        script.node(agent.label()) {
            setup_node()
            run_tests()
            create_release_package()
        }
    }

    void setup_node() {
        configure_git()

        // Only unpackage tentative when running on a different node
        if (agent != build.agent) {
            script.stage("Unpackage " + target.short_label()) {
                cleanUp()
                unpackage_tentative()
            }
        }
    }

    void unpackage_tentative() {
        script.unstash "${GlamorousToolkit.TENTATIVE_PACKAGE}"
        download_installer()
        platform().exec(script, "./gt-installer", "--verbose unpackage-tentative ${GlamorousToolkit.TENTATIVE_PACKAGE}")
    }

    void run_tests() {
        if (runTests) {
            script.stage("Test " + target.short_label()) {
                script.timeout(time: 2, unit: 'HOURS') {
                    prepare_for_testing()
                    run_gtoolkit_examples()
                    run_extra_examples()
                    run_pharo_tests()
                    report_test_results() 
                }
            }
        }
    }

    void prepare_for_testing() {
        // make a copy from GTOOLKIT_FOLDER to the EXAMPLES_FOLDER
        platform().exec(script, "./gt-installer", "--verbose copy-to ${GlamorousToolkit.EXAMPLES_FOLDER}")

        // On Windows we must disable the firewall for the exe, otherwise there will be no internet access when running examples / tests
        if (platform() == Platform.Windows) {
            script.powershell "netsh advfirewall firewall add rule name='Gt Examples cli exe' dir=in action=allow program='${GlamorousToolkit.EXAMPLES_FOLDER}\\bin\\GlamorousToolkit-cli.exe' enable=yes"
        }
    }

    void run_gtoolkit_examples() {
        delete_lepiter_directory()
        platform().exec_ui(script, "./gt-installer", "--verbose --workspace ${GlamorousToolkit.EXAMPLES_FOLDER} test ${GlamorousToolkit.TEST_OPTIONS}")
    }

    void run_extra_examples() {

    }

    /**
     * Runs Pharo TestCase in a few selected packages to verify that the VM works good enough to support base Pharo features.
     */
    void run_pharo_tests() {
        delete_lepiter_directory()
        platform().exec_ui(script, "./gt-installer", "--verbose --workspace ${GlamorousToolkit.EXAMPLES_FOLDER} test --packages 'Zinc.*' 'Zodiac.*'")
    }

    /**
     * Analyses and reports the test results.
     * Should be executed after running all examples and tests.
     */
    void report_test_results() {
        script.junit "${GlamorousToolkit.EXAMPLES_FOLDER}/*.xml"
    }

    /**
     * Create a package ready for release
     */
    void create_release_package() {
        def currentResult = script.currentBuild.result ?: 'SUCCESS'
        // we must not package the build if not successful until this point
        if (currentResult != 'SUCCESS') {
            return;
        }

        create_release_package_for_target(this.target)
        for(int target in this.extraTargets) {
            create_release_package_for_target(target)
        }
    }

    void create_release_package_for_target(Triplet target) {
        script.stage("Package " + target.short_label()) {
            def targetString = target.toString()
            def release_package = platform().exec_stdout(script, "./gt-installer", "package-release \"${GlamorousToolkit.RELEASE_PACKAGE_TEMPLATE}\" --target \"${targetString}\"")
            script.echo "Created release package ${release_package}"
            sign_package(release_package, target)
            build.stash_for_release(release_package, targetString)
        }
    }

    /**
     * Sign the prepared package.
     * Only supported when targeting MacOS.
     */
    void sign_package(String release_package, Triplet target) {
        if (target.platform() != Platform.MacOS) {
            return
        }

        script.withCredentials([
            script.string(credentialsId: 'notarizeusername', variable: 'APPLE_ID'),
            script.string(credentialsId: 'notarizepassword-manager', variable: 'APPLE_PASSWORD')
        ]) {
            script.sh """
               /Library/Developer/CommandLineTools/usr/bin/notarytool submit \
                    --verbose \
                    --apple-id "\$APPLE_ID" \
                    --password "\$APPLE_PASSWORD" \
                    --team-id "77664ZXL29" \
                    --wait \
                    ${release_package}
               """
        }

        script.echo "Signed release package ${release_package}"
    }
}

class TestAndPackageWithGemstoneAndPython extends TestAndPackage {
    static final GEMSTONE_FOLDER = "remote-gemstone"

    TestAndPackageWithGemstoneAndPython(GlamorousToolkit build, Agent agent, Triplet target) {
        super(build, agent, target)

        if (agent.host() != Triplet.Linux_X86_64) {
            script.error "Gemstone build is only supported on x86_64 linux"
        }
    }

    @Override
    void prepare_for_testing() {
        super.prepare_for_testing()

        script.sh """
            cd ${GlamorousToolkit.EXAMPLES_FOLDER}
            rm -rf gt4gemstone
            git clone https://github.com/feenkcom/gt4gemstone.git 
            cd gt4gemstone 
            git checkout ${build.gt4gemstoneCommitHash}
        """

        script.sh """
            cd ${GlamorousToolkit.EXAMPLES_FOLDER}
            rm -rf gtoolkit-remote
            git clone https://github.com/feenkcom/gtoolkit-remote.git
            cd gtoolkit-remote 
            git checkout ${build.gt4remoteCommitHash}
        """

        script.sh """
            cd ${GlamorousToolkit.EXAMPLES_FOLDER}
            rm -rf Sparkle
            git clone https://github.com/feenkcom/Sparkle.git
        """

        script.sh """
            cd ${GlamorousToolkit.EXAMPLES_FOLDER}
            chmod +x gt4gemstone/scripts/*.sh
            chmod +x gt4gemstone/scripts/release/*.sh
            chmod +x gtoolkit-remote/scripts/*.sh
        """

        script.sh """
            cd ${GlamorousToolkit.EXAMPLES_FOLDER}
            rm -rf PythonBridge
            git clone https://github.com/feenkcom/PythonBridge.git 
            cd PythonBridge 
            git checkout ${build.pythonBridgeCommitHash}
            chmod +x scripts/*.sh
        """
    }

    @Override
    void run_extra_examples() {
        delete_lepiter_directory()
        run_gemstone_examples()
        run_python_examples()
        release_gt4python()
    }

    void run_gemstone_examples() {
        script.withEnv([
                "GT_GEMSTONE_VERSION=3.7.1.4",
                "GEMSTONE_WORKSPACE=${script.env.WORKSPACE}/${GlamorousToolkit.EXAMPLES_FOLDER}/${GEMSTONE_FOLDER}",
                "GT4GEMSTONE_VERSION=${build.gtoolkitVersion}",
                "RELEASED_PACKAGE_GEMSTONE_NAME=${gemstone_package_name()}"]) {
            // Run the GemStone remote examples.
            // Relies on the Linux Examples stage configuring EXAMPLES_FOLDER correctly.
            script.sh """
                    cd ${GlamorousToolkit.EXAMPLES_FOLDER}
                    ./gt4gemstone/scripts/jenkins_preconfigure_gemstone.sh
                    ./gt4gemstone/scripts/run-remote-gemstone-examples.sh
                """
        }
    }

    void release_gt4python() {
        script.withCredentials([script.string(credentialsId: 'flit_password_pypi', variable: 'FLIT_PASSWORD')]) {
            // Run the PythonBridge release script.
            // Relies on the Linux Examples stage configuring EXAMPLES_FOLDER correctly.
            script.sh """
                    cd ${GlamorousToolkit.EXAMPLES_FOLDER}
                    cd PythonBridge/PyPI
                    ../scripts/publish_gtoolkit_bridge_PyPI.sh
                """
        }
    }

    void run_python_examples() {
        script.sh """
            cd ${GlamorousToolkit.EXAMPLES_FOLDER}
            ./PythonBridge/scripts/run_python_examples.sh
        """
    }

    String gemstone_package_name() {
        return "gt4gemstone-3.7"
    }

    @Override
    void create_release_package() {
        super.create_release_package()

        // Gemstone package is prepared during examples running step
        if (!build.runTests) {
            return
        }

        def gemstone_workspace = "${GlamorousToolkit.EXAMPLES_FOLDER}/${GEMSTONE_FOLDER}"
        def gemstone_package = "${gemstone_package_name()}.zip"

        script.sh "cp -rf ${gemstone_workspace}/${gemstone_package} ."
        build.stash_for_release(gemstone_package, 'GemStone')
    }
}

/**
 * Represents a Job that is assigned to be run on a specific agent.
 * @see Agent
 */
abstract class AgentJob {
    final GlamorousToolkit build
    final Script script
    // agent on which to build the image
    final Agent agent

    AgentJob(GlamorousToolkit build, Agent agent) {
        this.build = build
        this.script = build.script
        this.agent = agent
    }

    void cleanUp() {
        doCleanUp()
    }

    void doCleanUp() {
        if (build.cleanUp && build.freshBuild) {
            platform().delete_directory(script, GlamorousToolkit.RELEASER_FOLDER)
        }
        platform().delete_directory(script, GlamorousToolkit.GTOOLKIT_FOLDER)
        platform().delete_directory(script, GlamorousToolkit.EXAMPLES_FOLDER)
        delete_lepiter_directory()

        if (build.cleanUp && build.freshBuild && script.fileExists('.git')) {
            platform().shell(script, "git clean -fdx")
        }
        else {
            script.echo ".git does not exist, no need to clean"
        }
    }

    void delete_lepiter_directory() {
        platform().delete_directory(script, platform().lepiter_directory())
    }

    abstract void execute()

    void configure_git() {
        platform().shell(script, 'git config --global user.name "Jenkins"')
        platform().shell(script, 'git config --global user.email "jenkins@feenk.com"')
    }

    void download_installer() {
        platform().download_executable(script, installer_url(), "gt-installer")
    }

    String installer_url() {
        return "https://github.com/feenkcom/gtoolkit-maestro-rs/releases/download/${build.installerVersion}/gt-installer-${agent.host().toString()}"
    }

    Platform platform() {
        return agent.platform()
    }
}

class Agent {
    final Triplet host
    final String tag

    Agent(Triplet host) {
        this(host, null)
    }

    Agent(Triplet host, String tag) {
        this.host = host
        this.tag = tag
    }

    @NonCPS
    Triplet host() {
        return host
    }

    @NonCPS
    Platform platform() {
        return host.platform()
    }

    @java.lang.Override
    @NonCPS
    String toString() {
        return "Agent (" + label() + ")"
    }

    @NonCPS
    String label() {
        String host_string = host.toString()
        if (tag == null) {
            return host_string
        } else {
            return host_string + "-" + tag
        }
    }

    @Override
    @NonCPS
    boolean equals(object) {
        if (getClass() != object.getClass()) return false

        Agent agent = (Agent) object

        if (host != agent.host) return false
        if (tag != agent.tag) return false

        return true
    }

    @Override
    @NonCPS
    int hashCode() {
        int result = 7
        result = 31 * result + host.hashCode()
        result = 31 * result + (tag != null ? tag.hashCode() : 0)
        return result
    }
}

enum Triplet {
    MacOS_Aarch64(Platform.MacOS, Architecture.Aarch64),
    MacOS_X86_64(Platform.MacOS, Architecture.X86_64),
    Linux_Aarch64(Platform.Linux, Architecture.Aarch64),
    Linux_X86_64(Platform.Linux, Architecture.X86_64),
    Windows_Aarch64(Platform.Windows, Architecture.Aarch64),
    Windows_X86_64(Platform.Windows, Architecture.X86_64)

    final Platform platform
    final Architecture architecture

    Triplet(Platform platform, Architecture architecture) {
        this.platform = platform
        this.architecture = architecture
    }

    @NonCPS
    Platform platform() {
        return this.platform
    }

    @Override
    @NonCPS
    String toString() {
        this.architecture.toString() + "-" + this.platform.toString()
    }

    @NonCPS
    String short_label() {
        this.platform.short_label() + " " + this.architecture.short_label()
    }
}

/**
 * Encapsulates platform specific aspects of the build process
 */
enum Platform {
    Windows("pc-windows-msvc"),
    MacOS("apple-darwin"),
    Linux("unknown-linux-gnu")

    final String value

    Platform(String value) {
        this.value = value
    }

    @Override
    @NonCPS
    String toString() {
        this.value
    }

    @NonCPS
    String short_label() {
        switch (this) {
            case Windows:
                return "Windows"
                break
            case MacOS:
                return "MacOS"
                break
            case Linux:
                return "Linux"
                break
        }
    }

    /**
     * Platform specific Lepiter directory
     * @return - a String path to the lepiter directory depending on the platform
     * where the script is executed
     */
    String lepiter_directory() {
        if (this == Windows) {
            GlamorousToolkit.LEPITER_WINDOWS
        } else {
            GlamorousToolkit.LEPITER_UNIX
        }
    }

    void download_executable(Script script, String url, String executable) {
        if (this == Windows) {
            download_file(script, url + ".exe", executable + ".exe")
        } else {
            download_file(script, url, executable)
            script.sh "chmod +x ${executable}"
        }
    }

    void download_file(Script script, String url, String output) {
        delete_file(script, output)
        if (this == Windows) {
            script.powershell "curl -o ${output} ${url}"
        } else {
            script.sh "curl -o ${output} -LsS ${url}"
        }
    }

    void delete_directory(Script script, String directory) {
        if (this == Windows) {
            script.powershell "Remove-Item ${directory} -Recurse -ErrorAction Ignore"
        } else {
            script.sh("""
                if [ -d ${directory} ]
                then
                    echo "Granting write permission for cleanup: ${directory}"
                    chmod -R u+w ${directory}
                fi
                rm -rf ${directory}
            """)
        }
    }

    void delete_file(Script script, String file) {
        if (this == Windows) {
            script.powershell "Remove-Item ${file} -ErrorAction Ignore"
        } else {
            script.sh "rm -rf ${file}"
        }
    }

    void exec(Script script, String executable, String arguments) {
        if (this == Windows) {
            shell(script, "${executable}.exe $arguments")
        } else {
            shell(script, "${executable} $arguments")
        }
    }

    void exec_ui(Script script, String executable, String arguments) {
        if (this == Windows) {
            shell(script, "${executable}.exe $arguments")
        } else if (this == MacOS) {
            shell(script, "${executable} $arguments")
        } else {
            shell(script, "xvfb-run -a ./${executable} $arguments")
        }
    }

    String exec_stdout(Script script, String executable, String arguments, String path = null) {
        def exec_path = path ?: "."
        def output = ""
        if (this == Windows) {
            output = script.powershell script: """
                cd ${exec_path}; `
                ${executable}.exe ${arguments} """, returnStdout: true
        } else {
            output = script.sh script: """
            cd ${exec_path} && \
            ${executable} ${arguments} """, returnStdout: true
        }
        return output.trim()
    }

    void shell(Script script, String command) {
        if (this == Windows) {
            script.powershell "${command}"
        } else {
            script.sh "${command}"
        }
    }
}

enum Architecture {
    Aarch64("aarch64"),
    X86_64("x86_64")

    final String value

    Architecture(String value) {
        this.value = value
    }

    @NonCPS
    String short_label() {
        switch (this) {
            case Aarch64:
                return "Arm64"
                break
            case X86_64:
                return "x86_64"
                break
        }
    }

    @Override
    @NonCPS
    String toString() {
        this.value
    }
}

@NonCPS
String getFailedTests() {
    def testResultAction = currentBuild.rawBuild.getAction(AbstractTestResultAction.class)
    def failedTestsString = "```"

    if (testResultAction != null) {
        def failedTests = testResultAction.getFailedTests()

        if (failedTests.size() > 9) {
            failedTests = failedTests.subList(0, 8)
        }

        for (CaseResult cr : failedTests) {
            failedTestsString = failedTestsString + "${cr.getFullDisplayName()}:\n${cr.getErrorDetails()}\n\n"
        }
        failedTestsString = failedTestsString + "```"
    }
    return failedTestsString
}

@NonCPS
String getTestSummary() {
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
