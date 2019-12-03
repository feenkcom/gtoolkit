#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=1

wget https://files.pharo.org/image/80/Pharo8.0-SNAPSHOT.build.1028.sha.327e19b.arch.64bit.zip -O Pharo.zip
unzip Pharo.zip
mv Pharo8.0*.image Pharo.image
mv Pharo8.0*.changes Pharo.changes

curl https://dl.feenk.com/gtvm/Pharo-8.2.0-654ac0031-linux64-bin.zip -o Pharo-8.2.0-654ac0031-linux64-bin.zip
unzip Pharo-8.2.0-654ac0031-linux64-bin.zip

xvfb-run -a -e /dev/stdout ./pharo Pharo.image st --quit scripts/build/loadtag.st 2>&1

exit 0
