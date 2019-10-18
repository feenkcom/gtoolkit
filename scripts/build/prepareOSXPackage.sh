#!/bin/sh
set -e

GTFolder=GToolkitOSX64-$TAG_NAME
mkdir -p $GTFolder
cp -rv GToolkit-64*/* $GTFolder
rm -rf $GTFolder/pharo-local

libFolder=libOSX64-$TAG_NAME
mkdir -p $libFolder

# curl http://files.pharo.org/get-files/80/pharo64-mac-headless-latest.zip -o pharo64-mac-headless-latest.zip
# unzip pharo64-mac-headless-latest.zip -d $GTFolder/

curl https://dl.feenk.com/gtvm/PharoVM-8.1.0-4a6a3adc5-mac64-bin.zip -o PharoVM-8.1.0-4a6a3adc5-mac64-bin.zip
unzip PharoVM-8.1.0-4a6a3adc5-mac64-bin.zip -d $GTFolder/

curl https://dl.feenk.com/Glutin/osx/development/x86_64/libGlutin.dylib -o libGlutin.dylib
cp libGlutin.dylib $GTFolder
cp libGlutin.dylib $libFolder

curl https://dl.feenk.com/Moz2D/osx/development/x86_64/libMoz2D.dylib -o libMoz2D.dylib
cp libMoz2D.dylib $GTFolder
cp libMoz2D.dylib $libFolder

curl https://dl.feenk.com/Clipboard/osx/development/x86_64/libClipboard.dylib -o libClipboard.dylib
cp libClipboard.dylib $GTFolder
cp libClipboard.dylib $libFolder

zip -qyr $GTFolder.zip $GTFolder
zip -qyr $libFolder.zip $libFolder
rm -rf $GTFolder
rm -rf $libFolder
set +e