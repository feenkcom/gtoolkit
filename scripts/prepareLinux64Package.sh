#!/bin/sh
set -e
curl https://dl.feenk.com/gt/GToolkit64.zip -o GToolkit64.zip
unzip -u GToolkit64.zip
mkdir -p GToolkitLinux64
cp -r GToolkit-64*/ GToolkitLinux64

curl https://get.pharo.org/64/vmLatest70 | bash
mv -fv pharo-ui GToolkitLinux64/
mv -fv pharo GToolkitLinux64/
mv -fv pharo-vm GToolkitLinux64/
zip -qyr GToolkitLinux64.zip GToolkitLinux64
scp GToolkitLinux64.zip ubuntu@ec2-35-157-37-37.eu-central-1.compute.amazonaws.com:/var/www/html/gt/
