#!/bin/sh
set -e

GTFolder=GToolkitOSX64-$TAG_NAME
mkdir -p $GTFolder
cp -rv GToolkit-64*/* $GTFolder
rm -rf $GTFolder/pharo-local

curl https://dl.feenk.com/pharovm/Pharo.app.zip -o Pharo.app.zip
unzip Pharo.app.zip
mv -fv Pharo.app $GTFolder/

curl https://dl.feenk.com/Glutin/osx/development/x86_64/libGlutin.dylib -o libGlutin.dylib
mv libGlutin.dylib $GTFolder

curl https://dl.feenk.com/Moz2D/osx/development/x86_64/libMoz2D.dylib -o libMoz2D.dylib
mv libMoz2D.dylib $GTFolder

wget https://bintray.com/opensmalltalk/vm/download_file?file_path=pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201908070737.tar.gz -O pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201908070737.tar.gz
tar xvzf pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201908070737.tar.gz

GTOOLKIT_IMAGE=`find $GTFolder -type f -name "GToolkit-*.image"`

echo $GTOOLKIT_IMAGE

xvfb-run -a  ./phcogspurlinuxmhdls64/pharo $GTOOLKIT_IMAGE eval "GtWorld open. Smalltalk snapshot: true andQuit: true."

zip -qyr $GTFolder.zip $GTFolder
rm -rf $GTFolder
set +e