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

zip -qyr $GTFolder.zip $GTFolder
rm -rf $GTFolder
set +e