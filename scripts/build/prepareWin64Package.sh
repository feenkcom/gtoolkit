#!/bin/sh
set -e
#curl https://dl.feenk.com/gt/GToolkit64.zip -o GToolkit64.zip
#unzip -u GToolkit64.zip
mkdir -p GToolkitWin64
cp -rv GToolkit-64*/* GToolkitWin64

curl http://files.pharo.org/get-files/70/pharo64-win-latest.zip -o pharo64-win-latest.zip
unzip pharo64-win-latest.zip -d pharo64-win-latest
mv -fv pharo64-win-latest/* GToolkitWin64/
zip -qyr GToolkitWin64.zip GToolkitWin64
set +e
# scp GToolkitWin64.zip ubuntu@ec2-35-157-37-37.eu-central-1.compute.amazonaws.com:/var/www/html/gt/
