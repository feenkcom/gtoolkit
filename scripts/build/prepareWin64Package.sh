#!/bin/sh
set -e
set -o xtrace
GTFolder=GToolkitWin64-$TAG_NAME
mkdir -p $GTFolder
cp -rv GToolkit-64*/* $GTFolder
rm -rf $GTFolder/pharo-local


libFolder=libWin64-$TAG_NAME
mkdir -p $libFolder


curl https://ci.inria.fr/pharo-ci-jenkins2/job/pharo-vm/view/change-requests/job/PR-42/lastSuccessfulBuild/artifact/build/build/packages/PharoVM-8.1.0-432674b27-win64-bin.zip -o PharoVM-8.1.0-432674b27-win64-bin.zip
unzip PharoVM-8.1.0-432674b27-win64-bin.zip -d $GTFolder/

# curl https://files.pharo.org/get-files/80/pharo64-win-headless-latest.zip -o pharo64-win-headless-latest.zip
# unzip pharo64-win-headless-latest.zip -d $GTFolder/

# wget https://bintray.com/opensmalltalk/vm/download_file?file_path=pharo.cog.spur-cmake-minhdls_win64x64_201908212333.zip -O pharo.cog.spur-cmake-minhdls_win64x64_201908212333.zip
# unzip pharo.cog.spur-cmake-minhdls_win64x64_201908212333.zip -d pharo64-win-stable
# mv -fv pharo64-win-stable/* $GTFolder/

curl https://dl.feenk.com/Glutin/windows/development/x86_64/libGlutin.dll -o libGlutin.dll
curl https://dl.feenk.com/Moz2D/windows/development/x86_64/msvcp140.dll -o msvcp140.dll
curl https://dl.feenk.com/Moz2D/windows/development/x86_64/vcruntime140.dll -o vcruntime140.dll
curl https://dl.feenk.com/Moz2D/windows/development/x86_64/libMoz2D.dll -o libMoz2D.dll
curl https://dl.feenk.com/Clipboard/windows/development/x86_64/libClipboard.dll -o libClipboard.dll

cp libGlutin.dll $GTFolder
cp msvcp140.dll $GTFolder
cp vcruntime140.dll $GTFolder
cp libMoz2D.dll $GTFolder
cp libClipboard.dll $GTFolder

cp libGlutin.dll $libFolder
cp msvcp140.dll $libFolder
cp vcruntime140.dll $libFolder
cp libMoz2D.dll $libFolder
cp libClipboard.dll $libFolder

zip -qyr $GTFolder.zip $GTFolder
zip -qyr $libFolder.zip $libFolder
rm -rf $GTFolder
rm -rf $libFolder
set +e

