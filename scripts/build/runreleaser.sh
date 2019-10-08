#/bin/sh!
set -o xtrace
set -e

rm -f newcommits.txt
xvfb-run -a -e /dev/stdout ./pharo Pharo.image eval --save "GtPharoCompletionStrategy unsubscribeFromSystem"
xvfb-run -a -e /dev/stdout ./pharo Pharo.image releasegtoolkit ${FORCED_TAG_NAME}

set +e


