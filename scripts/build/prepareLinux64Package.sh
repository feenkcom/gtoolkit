#!/bin/sh
set -e
GTFolder=GToolkitLinux64-$TAG_NAME
mkdir -p $GTFolder
cp -rv GToolkit-64*/* $GTFolder
rm -rf $GTFolder/pharo-local

curl https://files.pharo.org/get-files/70/pharo64-linux-stable.zip -o pharo64-linux-stable.zip
unzip pharo64-linux-stable.zip -d pharo64-linux-stable
mv -fv pharo64-linux-stable/* $GTFolder/

curl https://dl.feenk.com/Glutin/linux/development/x86_64/libGlutin.so -o libGlutin.so
mv libGlutin.so $GTFolder

curl https://dl.feenk.com/Moz2D/linux/development/x86_64/libMoz2D.so -o libMoz2D.so
mv libMoz2D.so $GTFolder

zip -qyr $GTFolder.zip $GTFolder
rm -rf $GTFolder
set +e