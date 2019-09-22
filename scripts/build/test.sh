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

export build_zip="${ARTIFACT_DIR}.zip"
zip -qr "$build_zip" "$ARTIFACT_DIR"

#if we are in a tag build, then save the image with GtWorld opened
if [ ! -z "${TAG_NAME}" ]
then
  #download a minheadless vm and save the image with GtWorld opened
  wget https://bintray.com/opensmalltalk/vm/download_file?file_path=pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201909110300.tar.gz -O pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201909110300.tar.gz
  tar xvzf pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201909110300.tar.gz

  xvfb-run -a  ./phcogspurlinuxmhdls64/pharo "${ARTIFACT_DIR}/${PROJECT_NAME}64.image" eval "GtWorld open. [ 2 seconds wait. BlHost pickHost universe snapshot: true andQuit: true ] fork."
fi

set +e
#run unit tests
git config --global user.name "Jenkins"
git config --global user.email "jenkins@feenk.com"
xvfb-run -a -e /dev/stdout ./pharo Pharo.image examples --junit-xml-output 'GToolkit-.*' 'GT4SmaCC-.*' 'DeepTraverser-.*' 'Brick' 'Brick-.*' 'Bloc' 'Bloc-.*' 'Starta-.*' 2>&1
xvfb-run -a -e /dev/stdout ./pharo Pharo.image gtexportreport --report=GtGtoolkitArchitecturalReport



#if we are in a tag build, then srun smoke tests
if [ ! -z "${TAG_NAME}" ]
then
  set -e

  #run smoke tests
  timeout 20 xvfb-run -a ./phcogspurlinuxmhdls64/pharo "${ARTIFACT_DIR}/${PROJECT_NAME}64.image" &
  sleep 3
  export DISPLAY=$(ps -aux | grep screen -m 1 | awk '{print $12}')
  export XAUTHORITY=$(ps -aux | grep screen -m 1 | awk '{print $19}')
  xwd -display $DISPLAY -id 0x1e4 -out gt.xwd
  convert -verbose gt.xwd gt.jpg

  ls -al

  if [ $(find gt.jpg -type f -size +20000c 2>/dev/null) ] 
  then
      echo "Screenshot looking good."
  else 
      ls -al
      echo "gt.jpg does not exist or is too small. Exiting with 1 in order to fail the build."
      exit 1
  fi
fi
