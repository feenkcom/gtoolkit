#!/bin/sh
set -e

GTFolder=GToolkitOSX64-$TAG_NAME
mkdir -p $GTFolder
cp -rv GToolkit-64*/* $GTFolder
rm -rf $GTFolder/pharo-local

curl http://files.pharo.org/get-files/80/pharo64-mac-headless-latest.zip -o pharo64-mac-headless-latest.zip
unzip pharo64-mac-headless-latest.zip -d $GTFolder/

curl https://dl.feenk.com/Glutin/osx/development/x86_64/libGlutin.dylib -o libGlutin.dylib
mv libGlutin.dylib $GTFolder

curl https://dl.feenk.com/Moz2D/osx/development/x86_64/libMoz2D.dylib -o libMoz2D.dylib
mv libMoz2D.dylib $GTFolder

curl https://dl.feenk.com/Clipboard/osx/development/x86_64/libClipboard.dylib -o libClipboard.dylib
mv libClipboard.dylib $GTFolder

zip -qyr $GTFolder.zip $GTFolder
rm -rf $GTFolder
set +e