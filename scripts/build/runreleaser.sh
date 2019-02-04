#/bin/sh!
set -o xtrace
echo $DISPLAY
export DISPLAY=:99.0
./pharo Pharo.image st --quit scripts/build/icebergconfig.st  2>&1
./pharo-ui Pharo.image releasegtoolkit ${FORCED_TAG_NAME}
exit 0