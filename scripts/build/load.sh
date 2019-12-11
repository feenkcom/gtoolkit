#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=1

wget https://files.pharo.org/image/80/Pharo8.0-SNAPSHOT.build.1059.sha.9dd40fe.arch.64bit.zip -O Pharo.zip
unzip Pharo.zip
mv Pharo8.0*.image Pharo.image
mv Pharo8.0*.changes Pharo.changes

# curl https://get.pharo.org/64/80 | bash

curl https://dl.feenk.com/gtvm/Pharo-8.2.0-654ac0031-linux64-bin.zip -o Pharo-8.2.0-654ac0031-linux64-bin.zip
unzip Pharo-8.2.0-654ac0031-linux64-bin.zip


xvfb-run -a -e /dev/stdout ./pharo Pharo.image st --quit scripts/build/loadgt.st  2>&1
rm -f newcommits*
xvfb-run -a -e /dev/stdout ./pharo Pharo.image printNewCommits
exit 0
