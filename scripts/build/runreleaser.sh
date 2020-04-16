#/bin/sh!
set -o xtrace
set -e

xvfb-run -a -e /dev/stdout ./glamoroustoolkit Pharo.image eval --save "GtPharoCompletionStrategy unsubscribeFromSystem"
xvfb-run -a -e /dev/stdout ./glamoroustoolkit Pharo.image releasegtoolkit ${FORCED_TAG_NAME}

set +e


