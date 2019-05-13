#/bin/sh!
set -o xtrace
set -e

xvfb-run -a -e /dev/stdout ./pharo Pharo.image releasegtoolkit ${FORCED_TAG_NAME}
