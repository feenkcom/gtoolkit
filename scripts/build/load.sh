#/bin/sh!
set -o xtrace
set -e
export RUST_BACKTRACE=full

TAG_NAME=$(git ls-remote --tags git@github.com:feenkcom/gtoolkit.git | grep /v0 | sort -t '/' -k 3 -V | tail -n1 |sed 's/.*\///; s/\^{}//')
TAG=$(echo $TAG_NAME | cut -d'.' -f3)
echo $TAG

curl https://get.pharo.org/64/80 | bash

sh scripts/build/downloadLatestVM.sh
unzip build-artifacts.zip
unzip build-artifacts/GlamorousToolkitVM-*-linux64-bin.zip

xvfb-run -a -e /dev/stdout ./glamoroustoolkit --version 2>&1
xvfb-run -a -e /dev/stdout ./glamoroustoolkit Pharo.image st --quit scripts/build/loadgt.st  2>&1
rm -f newcommits*
xvfb-run -a -e /dev/stdout ./glamoroustoolkit Pharo.image eval "ThreadedFFIMigration gtTFFIversionString" 2>&1
xvfb-run -a -e /dev/stdout ./glamoroustoolkit Pharo.image printNewCommits
