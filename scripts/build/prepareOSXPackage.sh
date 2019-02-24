#!/bin/sh
set -e
GTFolder=GToolkitOSX64-$TAG_NAME
mkdir -p $GTFolder
cp -rv GToolkit-64*/* $GTFolder

curl https://files.pharo.org/get-files/70/pharo64-mac-stable.zip -o pharo64-mac-stable.zip
unzip pharo64-mac-stable.zip -d pharo64-mac-stable
mv -fv pharo64-mac-stable/* $GTFolder/
zip -qyr $GTFolder.zip $GTFolder
rm -rf $GTFolder
set +e