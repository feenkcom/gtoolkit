#!/bin/sh
set -e
set -o xtrace
GTFolder=GToolkitWin64-$TAG_NAME
mkdir -p $GTFolder
cp -rv GToolkit-64*/* $GTFolder
rm -rf $GTFolder/pharo-local

curl http://files.pharo.org/get-files/70/pharo64-win-stable.zip -o pharo64-win-stable.zip
unzip pharo64-win-stable.zip -d pharo64-win-stable
mv -fv pharo64-win-stable/* $GTFolder/

curl https://dl.feenk.com/Glutin/windows/development/x86_64/libGlutin.dll -o libGlutin.dll
curl https://dl.feenk.com/Moz2D/windows/development/x86_64/msvcp140.dll -o msvcp140.dll
curl https://dl.feenk.com/Moz2D/windows/development/x86_64/vcruntime140.dll -o vcruntime140.dll
curl https://dl.feenk.com/Moz2D/windows/development/x86_64/libMoz2D.dll -o libMoz2D.dll
mv libGlutin.dll $GTFolder
mv msvcp140.dll $GTFolder
mv vcruntime140.dll $GTFolder
mv libMoz2D.dll $GTFolder

zip -qyr $GTFolder.zip $GTFolder
rm -rf $GTFolder
set +e

