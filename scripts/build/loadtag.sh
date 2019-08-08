#/bin/sh!
set -o xtrace
export RUST_BACKTRACE=1

curl https://get.pharo.org/64/stable+vm | bash
xvfb-run -a -e /dev/stdout ./pharo Pharo.image st --quit scripts/build/icebergconfig.st  2>&1
xvfb-run -a -e /dev/stdout ./pharo Pharo.image st --quit scripts/build/loadtag.st 2>&1

xvfb-run -a -e /dev/stdout ./pharo Pharo.image  st --quit scripts/build/icebergunconfig.st  2>&1
xvfb-run -a -e /dev/stdout ./pharo Pharo.image  eval --save 'IceRepository registry removeAll.'

#download a minheadless vm and save the image with GtWorld opened.
wget https://bintray.com/opensmalltalk/vm/download_file?file_path=pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201908070737.tar.gz -O pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201908070737.tar.gz
tar xvzf pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201908070737.tar.gz

xvfb-run -a  ./phcogspurlinuxmhdls64/pharo Pharo.image eval "GtWorld open. Smalltalk snapshot: true andQuit: true."
exit 0
