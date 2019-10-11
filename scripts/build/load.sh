#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=1
curl https://get.pharo.org/64/80+vm| bash
xvfb-run -a -e /dev/stdout ./pharo Pharo.image st --quit scripts/build/icebergconfig.st  2>&1
xvfb-run -a -e /dev/stdout ./pharo Pharo.image st --quit scripts/build/loadgt.st  2>&1
rm -f newcommits.txt
xvfb-run -a -e /dev/stdout ./pharo Pharo.image printNewCommits
exit 0
