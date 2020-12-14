#/bin/sh!
set -o xtrace
set -e
export RUST_BACKTRACE=full

export PROJECT_NAME="GlamorousToolkit"

# customize the name of the build folder
export ARTIFACT_DIR="${PROJECT_NAME}"
mkdir "$ARTIFACT_DIR"
cp Pharo.image "${ARTIFACT_DIR}/${PROJECT_NAME}.image"
cp Pharo.changes "${ARTIFACT_DIR}/${PROJECT_NAME}.changes"
cp *.sources "${ARTIFACT_DIR}/"
cp -Rv gt-extra "${ARTIFACT_DIR}/"

export build_zip="${ARTIFACT_DIR}.zip"

xvfb-run -a  ./glamoroustoolkit "${ARTIFACT_DIR}/${PROJECT_NAME}.image" eval --save "IceCredentialsProvider sshCredentials publicKey: ''; privateKey: ''. IceCredentialsProvider useCustomSsh: false. IceRepository registry removeAll. 3 timesRepeat: [ Smalltalk garbageCollect ]." 

echo "ThreadedFFIMigration enableThreadedFFI. Smalltalk snapshot: true andQuit: true."  > tffi.st
xvfb-run -a  ./glamoroustoolkit "${ARTIFACT_DIR}/${PROJECT_NAME}.image"  st tffi.st
rm -rf ${ARTIFACT_DIR}/pharo-local
zip -qr "$build_zip" "$ARTIFACT_DIR"
cp $build_zip GT.zip

set +e

#ensure git config
git config --global user.name "Jenkins"
git config --global user.email "jenkins@feenk.com"

set -e
