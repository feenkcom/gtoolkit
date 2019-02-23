#/bin/sh!
set -o xtrace
set -e
echo $DISPLAY
export DISPLAY=:99.0
./pharo Pharo.image releasegtoolkit ${FORCED_TAG_NAME}
