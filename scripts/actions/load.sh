#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=full

wget https://files.pharo.org/image/80/Pharo8.0-SNAPSHOT.build.1059.sha.9dd40fe.arch.64bit.zip -O Pharo.zip
unzip Pharo.zip
mv Pharo8.0*.image Pharo.image
mv Pharo8.0*.changes Pharo.changes

curl https://dl.feenk.com/gtvm/Pharo-8.2.0-654ac0031-mac64-bin.zip -o Pharo-8.2.0-654ac0031-mac64-bin.zip
unzip Pharo-8.2.0-654ac0031-mac64-bin.zip


Pharo.app/Contents/MacOS/pharo Pharo.image st --quit scripts/actions/loadgt.st  2>&1
rm -f newcommits*
Pharo.app/Contents/MacOS/pharo Pharo.image printNewCommits
exit 0
