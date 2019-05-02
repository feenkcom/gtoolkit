#!/bin/sh
set -e
GTFolder=GToolkitWin64-$TAG_NAME
mkdir -p $GTFolder
cp -rv GToolkit-64*/* $GTFolder
rm -rf $GTFolder/pharo-local

curl http://files.pharo.org/get-files/70/pharo64-win-stable.zip -o pharo64-win-stable.zip
unzip pharo64-win-stable.zip -d pharo64-win-stable
mv -fv pharo64-win-stable/* $GTFolder/

curl https://dl.feenk.com/Glutin/windows/development/x86_64/libGlutin.dll -o libGlutin.dll
mv libGlutin.dll $GTFolder

zip -qyr $GTFolder.zip $GTFolder
rm -rf $GTFolder
set +e

