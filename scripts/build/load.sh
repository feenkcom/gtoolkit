#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=full

rm -rf Pharo8.0-SNAPSHOT*
curl https://files.pharo.org/image/80/Pharo8.0-SNAPSHOT.build.1114.sha.2258354.arch.64bit.zip -o Pharo8.0-SNAPSHOT.build.1114.sha.2258354.arch.64bit.zip
unzip Pharo8.0-SNAPSHOT.build.1114.sha.2258354.arch.64bit.zip
mv Pharo8.0-SNAPSHOT-64bit-*.image Pharo.image
mv Pharo8.0-SNAPSHOT-64bit-*.changes Pharo.changes

sh scripts/build/downloadLatestVM.sh
unzip build-artifacts.zip
unzip build-artifacts/GToolkitVM-8.2.0-*-linux64-bin.zip

xvfb-run -a -e /dev/stdout ./gtoolkit Pharo.image st --quit scripts/build/loadgt.st  2>&1
rm -f newcommits*
xvfb-run -a -e /dev/stdout ./gtoolkit Pharo.image printNewCommits
exit 0
