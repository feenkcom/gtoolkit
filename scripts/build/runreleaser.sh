#/bin/sh!
set -o xtrace
echo $DISPLAY
export DISPLAY=:99.0
./pharo Pharo.image releasegtoolkit ${FORCED_TAG_NAME}
exit 0