#/bin/sh!
set -o xtrace
set -e

./pharo Pharo.image releasegtoolkit ${FORCED_TAG_NAME}
