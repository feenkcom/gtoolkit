#!/bin/sh
set -e
curl https://dl.feenk.com/gt/GToolkit64.zip -o GToolkit64.zip
unzip -u GToolkit64.zip
mkdir -p GToolkit64OSX
cp -r GToolkit-64*/ GToolkit64OSX

curl https://get.pharo.org/64/vmLatest70 | bash
mv -fv pharo-ui GToolkit64OSX/
mv -fv pharo GToolkit64OSX/
mv -fv pharo-vm GToolkit64OSX/
zip -qyr GToolkit64OSX.zip GToolkit64OSX
scp GToolkit64OSX.zip ubuntu@ec2-35-157-37-37.eu-central-1.compute.amazonaws.com:/var/www/html/gt/
