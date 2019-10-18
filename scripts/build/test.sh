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
  #download a pharo headless vm and save the image with GtWorld opened

  curl https://files.pharo.org/get-files/80/pharo64-linux-headless-latest.zip -o pharo64-linux-headless-latest.zip
  unzip pharo64-linux-headless-latest.zip  -d phcogspurlinuxmhdls64

  # It is important to run headless vm with --interactive flag, otherwise the UI will not open
  # We should also pass --no-quit flag, otherwise the VM will be terminated before the universe ever gets a chance to save an image.
  # It takes significant amount of time to start GtWorld, so let's wait for 10 seconds to make sure everything is initialized
  # There is not need to run save and quit an image from a forked process, because the save request is deffered though the universe
  xvfb-run -a  ./phcogspurlinuxmhdls64/pharo "${ARTIFACT_DIR}/${PROJECT_NAME}64.image" eval --interactive --no-quit "GtWorld openWithShutdownListener. 10 seconds wait. BlHost pickHost universe snapshot: true andQuit: true"
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
  timeout 20 xvfb-run -a ./phcogspurlinuxmhdls64/pharo "${ARTIFACT_DIR}/${PROJECT_NAME}64.image" --interactive &
  sleep 10
  export DISPLAY=$(ps -aux | grep screen -m 1 | awk '{print $12}')
  export XAUTHORITY=$(ps -aux | grep screen -m 1 | awk '{print $19}')
  # It is enough to specify -root to take a screenshot of the main screen
  xwd -display $DISPLAY -root -out gt.xwd
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
