#/bin/sh!
set -o xtrace
set -e
export RUST_BACKTRACE=full

export PROJECT_NAME="GToolkit-64-$(date +'%Y%m%d%H%M%S')-$(git log --format=%h -1)"

echo $PROJECT_NAME > projectversion.txt

# customize the name of the build folder
export ARTIFACT_DIR="${PROJECT_NAME}"
mkdir "$ARTIFACT_DIR"
cp Pharo.image "${ARTIFACT_DIR}/${PROJECT_NAME}64.image"
cp Pharo.changes "${ARTIFACT_DIR}/${PROJECT_NAME}64.changes"
cp *.sources "${ARTIFACT_DIR}/"
cp -Rv gt-extra "${ARTIFACT_DIR}/"

export build_zip="${ARTIFACT_DIR}.zip"

xvfb-run -a  ./gtoolkit "${ARTIFACT_DIR}/${PROJECT_NAME}64.image" eval --save "IceCredentialsProvider sshCredentials publicKey: ''; privateKey: ''. IceCredentialsProvider useCustomSsh: false. IceRepository registry removeAll." 
# xvfb-run -a  ./gtoolkit "${ARTIFACT_DIR}/${PROJECT_NAME}64.image" eval --save "IceCredentialsProvider providerType: IceNonInteractiveCredentialsProvider. IceCredentialsProvider sshCredentials publicKey: ''; privateKey: ''. IceCredentialsProvider useCustomSsh: false. IceRepository registry removeAll." 
xvfb-run -a  ./gtoolkit "${ARTIFACT_DIR}/${PROJECT_NAME}64.image" eval --save "ThreadedFFIMigration enableThreadedFFI." 
zip -qr "$build_zip" "$ARTIFACT_DIR"
cp $build_zip GT.zip

set +e

#run unit tests
git config --global user.name "Jenkins"
git config --global user.email "jenkins@feenk.com"

xvfb-run -a -e /dev/stdout ./gtoolkit Pharo.image examples --junit-xml-output 'GToolkit-.*' 'GT4SmaCC-.*' 'DeepTraverser-.*' 'Brick' 'Brick-.*' 'Bloc' 'Bloc-.*' 'Sparta-.*' 2>&1
xvfb-run -a -e /dev/stdout ./gtoolkit Pharo.image gtexportreport --report=GtGtoolkitArchitecturalReport

set -e
