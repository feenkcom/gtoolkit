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

#run smoke tests
timeout 60 xvfb-run -a ./gtoolkit "${ARTIFACT_DIR}/${PROJECT_NAME}64.image" --interactive &
sleep 50
export DISPLAY=$(ps -aux | grep screen -m 1 | awk '{print $12}')
export XAUTHORITY=$(ps -aux | grep screen -m 1 | awk '{print $19}')
# It is enough to specify -root to take a screenshot of the main screen
xwd -display $DISPLAY -root -out gt.xwd
convert -verbose gt.xwd gt.jpg

if [ $(find gt.jpg -type f -size +20000c 2>/dev/null) ] 
then
    echo "Screenshot looking good."
else 
    ls -al
    echo "gt.jpg does not exist or is too small. Exiting with 1 in order to fail the build."
    exit 1
fi
