#!/bin/sh
set -e
GTFolder=GToolkitWin64-$TAG_NAME
mkdir -p $GTFolder
cp -rv GToolkit-64*/* $GTFolder

curl http://files.pharo.org/get-files/70/pharo64-win-stable.zip -o pharo64-win-stable.zip
unzip pharo64-win-stable.zip -d pharo64-win-stable
mv -fv pharo64-win-stable/* $GTFolder/
zip -qyr $GTFolder.zip $GTFolder
set +e

