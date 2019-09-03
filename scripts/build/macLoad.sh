#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=1
curl https://get.pharo.org/64/stable+vm | bash
./pharo Pharo.image st --quit scripts/build/icebergconfig.st  2>&1
./pharo Pharo.image st --quit scripts/build/loadgt.st  2>&1
exit 0
