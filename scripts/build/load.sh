#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=full

curl https://files.pharo.org/image/80/Pharo8.0-SNAPSHOT.build.1115.sha.053389c.arch.64bit.zip -o Pharo8.0-SNAPSHOT.build.1115.sha.053389c.arch.64bit.zip
unzip Pharo8.0-SNAPSHOT.build.1115.sha.053389c.arch.64bit.zip
mv Pharo8.0-SNAPSHOT-64bit-053389c.image Pharo.image
mv Pharo8.0-SNAPSHOT-64bit-053389c.changes Pharo.changes

sh scripts/build/downloadLatestVM.sh
unzip build-artifacts.zip
unzip build-artifacts/GToolkitVM-8.2.0-*-linux64-bin.zip

xvfb-run -a -e /dev/stdout ./gtoolkit Pharo.image st --quit scripts/build/loadgt.st  2>&1
rm -f newcommits*
xvfb-run -a -e /dev/stdout ./gtoolkit Pharo.image printNewCommits
exit 0
