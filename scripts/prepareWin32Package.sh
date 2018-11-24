#!/bin/sh
set -e
curl https://dl.feenk.com/gt/GToolkit32.zip -o GToolkit32.zip
unzip -u GToolkit32.zip
mkdir -p GToolkitWin32
cp -rv GToolkit-32*/* GToolkitWin32

curl https://files.pharo.org/platform/Pharo6.1-win.zip -o Pharo6.1-win.zip
unzip Pharo6.1-win.zip
mv -fv Pharo6.1/* GToolkitWin32/
rm GToolkitWin32/Pharo6.1.image
rm GToolkitWin32/Pharo6.1.changes
zip -qyr GToolkitWin32.zip GToolkitWin32
scp GToolkitWin32.zip ubuntu@ec2-35-157-37-37.eu-central-1.compute.amazonaws.com:/var/www/html/gt/
