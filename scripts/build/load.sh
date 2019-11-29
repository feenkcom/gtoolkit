#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=1
curl https://get.pharo.org/64/80 | bash
wget https://bintray.com/opensmalltalk/vm/download_file\?file_path\=pharo.cog.spur_linux64x64_201911282316.tar.gz -O vmakg.tar.gz
tar -xvf vmakg.tar.gz
mv phcogspur64linuxht/* .
rmdir phcogspur64linuxht

xvfb-run -a -e /dev/stdout ./pharo Pharo.image st --quit scripts/build/loadgt.st  2>&1
rm -f newcommits*
xvfb-run -a -e /dev/stdout ./pharo Pharo.image printNewCommits
exit 0
