#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=1
curl https://get.pharo.org/64/80 | bash
curl  https://get.pharo.org/64/vm70 | bash
xvfb-run -a -e /dev/stdout ./pharo Pharo.image st --quit scripts/build/icebergconfig.st  2>&1
xvfb-run -a -e /dev/stdout ./pharo Pharo.image st --quit scripts/build/loadgt.st  2>&1
exit 0
