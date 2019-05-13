#/bin/sh!
set -o xtrace
set -e

xvfb-run ./pharo Pharo.image releasegtoolkit ${FORCED_TAG_NAME}
