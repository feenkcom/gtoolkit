#!/bin/sh
set -e
curl https://dl.feenk.com/gt/GToolkit64.zip -o GToolkit64.zip
unzip -u GToolkit64.zip
mkdir -p GToolkitOSX64
cp -r GToolkit-64*/ GToolkitOSX64

curl https://get.pharo.org/64/vmLatest70 | bash
mv -fv pharo-ui GToolkitOSX64/
mv -fv pharo GToolkitOSX64/
mv -fv pharo-vm GToolkitOSX64/
zip -qyr GToolkitOSX64.zip GToolkitOSX64
scp GToolkitOSX64.zip ubuntu@ec2-35-157-37-37.eu-central-1.compute.amazonaws.com:/var/www/html/gt/
