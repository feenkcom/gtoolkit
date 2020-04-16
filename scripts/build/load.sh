#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=full

curl https://get.pharo.org/64/80 | bash

sh scripts/build/downloadLatestVM.sh
unzip build-artifacts.zip
unzip build-artifacts/GlamorousToolkitVM-8.2.0-*-linux64-bin.zip

xvfb-run -a -e /dev/stdout ./gtoolkit --version 2>&1
xvfb-run -a -e /dev/stdout ./gtoolkit Pharo.image st --quit scripts/build/loadgt.st  2>&1
rm -f newcommits*
xvfb-run -a -e /dev/stdout ./gtoolkit Pharo.image eval "ThreadedFFIMigration gtTFFIversionString" 2>&1
xvfb-run -a -e /dev/stdout ./gtoolkit Pharo.image printNewCommits
