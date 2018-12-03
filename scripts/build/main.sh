#/bin/sh!
set -o xtrace
echo $DISPLAY
export DISPLAY=:99.0
curl https://get.pharo.org/64/alpha+vm | bash
./pharo Pharo.image st --save --quit scripts/build/loadgt.st
./pharo-ui Pharo.image examples --junit-xml-output Bloc "Bloc-.*"