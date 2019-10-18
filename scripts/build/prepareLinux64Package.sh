#!/bin/sh
set -e
GTFolder=GToolkitLinux64-$TAG_NAME
mkdir -p $GTFolder
cp -rv GToolkit-64*/* $GTFolder
rm -rf $GTFolder/pharo-local

libFolder=libLinux64-$TAG_NAME
mkdir -p $libFolder

# curl https://files.pharo.org/get-files/80/pharo64-linux-headless-latest.zip -o pharo64-linux-headless-latest.zip 
# unzip pharo64-linux-headless-latest.zip  -d $GTFolder/

curl https://ci.inria.fr/pharo-ci-jenkins2/job/pharo-vm/view/change-requests/job/PR-42/lastSuccessfulBuild/artifact/build/build/packages/PharoVM-8.1.0-432674b-linux64-bin.zip -o PharoVM-8.1.0-432674b-linux64-bin.zip
unzip PharoVM-8.1.0-432674b-linux64-bin.zip -d $GTFolder/

curl https://dl.feenk.com/Glutin/linux/development/x86_64/libGlutin.so -o libGlutin.so
cp libGlutin.so $GTFolder
cp libGlutin.so $libFolder

curl https://dl.feenk.com/Moz2D/linux/development/x86_64/libMoz2D.so -o libMoz2D.so
cp libMoz2D.so $GTFolder
cp libMoz2D.so $libFolder

curl https://dl.feenk.com/Clipboard/linux/development/x86_64/libClipboard.so -o libClipboard.so
cp libClipboard.so $GTFolder
cp libClipboard.so $libFolder


zip -qyr $libFolder.zip $libFolder
zip -qyr $GTFolder.zip $GTFolder
rm -rf $libFolder
rm -rf $GTFolder
set +e