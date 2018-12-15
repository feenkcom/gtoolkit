#/bin/sh!
set -o xtrace
echo $DISPLAY
export DISPLAY=:99.0
xdpyinfo -display $DISPLAY > /dev/null || Xvfb $DISPLAY -screen 0 1024x768x16 &
curl https://get.pharo.org/64/alpha+vmLatest | bash
./pharo Pharo.image st --quit scripts/build/loadgt.st
exit 0