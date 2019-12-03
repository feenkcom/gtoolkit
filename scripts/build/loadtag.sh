#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=1

curl https://get.pharo.org/64/80 | bash

curl https://dl.feenk.com/gtvm/Pharo-8.2.0-654ac0031-linux64-bin.zip -o Pharo-8.2.0-654ac0031-linux64-bin.zip
unzip Pharo-8.2.0-654ac0031-linux64-bin.zip

xvfb-run -a -e /dev/stdout ./pharo Pharo.image st --quit scripts/build/loadtag.st 2>&1

exit 0
