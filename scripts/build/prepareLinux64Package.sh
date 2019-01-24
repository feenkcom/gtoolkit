#!/bin/sh
set -e
GTFolder=GToolkitLinux64-$TAG_NAME
mkdir -p $GTFolder
cp -rv GToolkit-64*/* $GTFolder

curl https://files.pharo.org/get-files/70/pharo64-linux-stable.zip -o pharo64-linux-stable.zip
unzip pharo64-linux-stable.zip -d pharo64-linux-stable
mv -fv pharo64-linux-stable/* $GTFolder/
zip -qyr $GTFolder.zip $GTFolder
set +e