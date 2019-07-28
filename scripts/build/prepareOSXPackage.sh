#!/bin/sh
set -e

GTFolder=GToolkitOSX64-$TAG_NAME
mkdir -p $GTFolder
cp -rv GToolkit-64*/* $GTFolder
rm -rf $GTFolder/pharo-local

curl https://files.pharo.org/get-files/70/pharo64-mac-stable.zip -o pharo64-mac-stable.zip
unzip pharo64-mac-stable.zip -d pharo64-mac-stable
mv -fv pharo64-mac-stable/* $GTFolder/

curl https://dl.feenk.com/Glutin/osx/development/x86_64/libGlutin.dylib -o libGlutin.dylib
mv libGlutin.dylib $GTFolder

curl https://dl.feenk.com/Moz2D/osx/development/x86_64/libMoz2D.dylib -o libMoz2D.dylib
mv libMoz2D.dylib $GTFolder

zip -qyr $GTFolder.zip $GTFolder
rm -rf $GTFolder
set +e