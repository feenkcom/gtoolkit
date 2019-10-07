#/bin/sh!
set -o xtrace
set -e

rm newcommits.txt
xvfb-run -a -e /dev/stdout ./pharo Pharo.image eval --save "GtPharoCompletionStrategy unsubscribeFromSystem"
xvfb-run -a -e /dev/stdout ./pharo Pharo.image releasegtoolkit ${FORCED_TAG_NAME}

export NEWCOMMITS=$(cat newcommits.txt)

