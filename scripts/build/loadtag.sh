#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=1

curl https://get.pharo.org/64/80+vm | bash

xvfb-run -a -e /dev/stdout ./pharo Pharo.image st --quit scripts/build/loadtag.st 2>&1

xvfb-run -a -e /dev/stdout ./pharo Pharo.image  st --quit scripts/build/icebergunconfig.st  2>&1
xvfb-run -a -e /dev/stdout ./pharo Pharo.image  eval --save 'IceRepository registry removeAll.'

exit 0
