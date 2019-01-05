#/bin/sh!
set -o xtrace
echo $DISPLAY
export DISPLAY=:99.0
./pharo Pharo.image st --quit scripts/build/runreleaser.st 2>&1
exit 0