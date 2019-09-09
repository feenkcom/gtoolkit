#/bin/sh!
set -o xtrace
set -e
export RUST_BACKTRACE=1

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

#download a minheadless vm and save the image with GtWorld opened.
wget https://bintray.com/opensmalltalk/vm/download_file?file_path=pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201908070737.tar.gz -O pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201908070737.tar.gz
tar xvzf pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201908070737.tar.gz

xvfb-run -a  ./phcogspurlinuxmhdls64/pharo "${ARTIFACT_DIR}/${PROJECT_NAME}64.image" eval "GtWorld open. 2 seconds wait. Smalltalk snapshot: true andQuit: true."

export build_zip="${ARTIFACT_DIR}.zip"
zip -qr "$build_zip" "$ARTIFACT_DIR"

set +e

git config --global user.name "Jenkins"
git config --global user.email "jenkins@feenk.com"
xvfb-run -a -e /dev/stdout ./pharo Pharo.image examples --junit-xml-output 'GToolkit-.*' 'GT4SmaCC-.*' 'DeepTraverser-.*' 'Brick' 'Brick-.*' 'Bloc' 'Bloc-.*' 'Starta-.*' 2>&1
xvfb-run -a -e /dev/stdout ./pharo Pharo.image gtexportreport --report=GtGtoolkitArchitecturalReport
