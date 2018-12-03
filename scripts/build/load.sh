#/bin/sh!
set -o xtrace
echo $DISPLAY
export DISPLAY=:99.0
curl https://get.pharo.org/64/alpha+vm | bash
./pharo Pharo.image st --quit scripts/build/loadgt.st
exit 0