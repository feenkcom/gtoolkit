#/bin/sh!
set -o xtrace
set -e
echo $DISPLAY
export DISPLAY=:99.0

if [ -z "${TAG_NAME}" ] 
then
  export PROJECT_NAME="GToolkit-64-$(date +'%Y%m%d%H%M%S')-$(git log --format=%h -1)"
else
  export PROJECT_NAME="GToolkit-64-${TAG_NAME}-$(date +'%Y%m%d%H%M%S')"
fi

#save the date so we can show it in the download button
date +%s > releasedateinseconds

# customize the name of the build folder
export ARTIFACT_DIR="${PROJECT_NAME}"
mkdir "$ARTIFACT_DIR"
cp Pharo.image "${ARTIFACT_DIR}/${PROJECT_NAME}64.image"
cp Pharo.changes "${ARTIFACT_DIR}/${PROJECT_NAME}64.changes"
cp *.sources "${ARTIFACT_DIR}/"
cp -Rv gt-extra "${ARTIFACT_DIR}/"
sh scripts/build/installMozz2d.sh
export build_zip="${ARTIFACT_DIR}.zip"
zip -qr "$build_zip" "$ARTIFACT_DIR"

set +e
./pharo "${ARTIFACT_DIR}/${PROJECT_NAME}64.image" st --quit scripts/build/icebergunconfig.st  2>&1
./pharo "${ARTIFACT_DIR}/${PROJECT_NAME}64.image" eval --save 'IceRepository registry removeAll.'

git config --global user.name "Jenkins"
git config --global user.email "jenkins@feenk.com"
./pharo Pharo.image examples --junit-xml-output 'GToolkit-.*' 2>&1

exit 0