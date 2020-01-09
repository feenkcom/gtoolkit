#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=full

curl https://get.pharo.org/64/80 | bash

curl https://dl.feenk.com/gtvm/GToolkitVM-8.2.0-ea61a04db-linux64-bin.zip -o GToolkitVM-8.2.0-ea61a04db-linux64-bin.zip
unzip GToolkitVM-8.2.0-ea61a04db-linux64-bin.zip

xvfb-run -a -e /dev/stdout ./gtoolkit Pharo.image st --quit scripts/build/loadgt.st  2>&1
rm -f newcommits*
xvfb-run -a -e /dev/stdout ./gtoolkit Pharo.image printNewCommits
exit 0
