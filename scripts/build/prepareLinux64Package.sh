#!/bin/sh
set -e
curl https://dl.feenk.com/gt/GToolkit64.zip -o GToolkit64.zip
unzip -u GToolkit64.zip
mkdir -p GToolkitLinux64
cp -r GToolkit-64*/* GToolkitLinux64

curl https://files.pharo.org/get-files/70/pharo64-linux-latest.zip -o pharo64-linux-latest.zip
unzip pharo64-linux-latest.zip -d pharo64-linux-latest
mv -fv pharo64-linux-latest/* GToolkitLinux64/
zip -qyr GToolkitLinux64.zip GToolkitLinux64
# scp GToolkitLinux64.zip ubuntu@ec2-35-157-37-37.eu-central-1.compute.amazonaws.com:/var/www/html/gt/
set +e