#/bin/sh!
set -o xtrace
curl https://get.pharo.org/64/stable+vm | bash
xvfb-run ./pharo Pharo.image st --quit scripts/build/icebergconfig.st  2>&1
xvfb-run ./pharo Pharo.image st --quit scripts/build/loadgt.st  2>&1
exit 0