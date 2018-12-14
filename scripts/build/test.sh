#/bin/sh!
set -o xtrace
set -e
echo $DISPLAY
export DISPLAY=:99.0

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

set +e
./pharo-ui Pharo.image examples --junit-xml-output 'GToolkit-.*' 2>&1
export AWS=ubuntu@ec2-35-157-37-37.eu-central-1.compute.amazonaws.com
export GTfolder=/var/www/html/gt/
#scp $build_zip $AWS:$GTfolder
exit 0