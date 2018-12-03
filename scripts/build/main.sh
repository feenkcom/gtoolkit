#/bin/sh!
set -o xtrace
echo $DISPLAY
export DISPLAY=:99.0
curl https://get.pharo.org/64/alpha+vm | bash
./pharo Pharo.image st --quit scripts/build/loadgt.st
export PROJECT_NAME="GToolkit-64-$(date +'%Y%m%d%H%M%S')-$(git log --format=%h -1)"
# customize the name of the build folder
export ARTIFACT_DIR="${PROJECT_NAME}"
mkdir "$ARTIFACT_DIR"
cp Pharo.image "${ARTIFACT_DIR}/${PROJECT_NAME}64.image"
cp Pharo.changes "${ARTIFACT_DIR}/${PROJECT_NAME}64.changes"
cp *.sources "${ARTIFACT_DIR}/"
cp -Rv gt-extra "${ARTIFACT_DIR}/"
sh scripts/installMozz2d.sh
export build_zip="${ARTIFACT_DIR}.zip"
zip -qr "$build_zip" "$ARTIFACT_DIR"
cp "$build_zip" "GToolkit64".zip
./pharo-ui Pharo.image examples --junit-xml-output 'GToolkit-.*'
sh scripts/build/prepareWin64Package.sh
sh scripts/build/prepareOSXPackage.sh
sh scripts/build/prepareLinux64Package.sh
exit 0