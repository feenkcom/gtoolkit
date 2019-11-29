#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=1

curl https://get.pharo.org/64/80 | bash
curl https://dl.feenk.com/gtvm/vmakg.tar.gz -o vmakg.tar.gz
tar -xvf vmakg.tar.gz
mv vmakg/* .
rmdir vmakg

xvfb-run -a -e /dev/stdout ./pharo Pharo.image st --quit scripts/build/loadtag.st 2>&1

exit 0
