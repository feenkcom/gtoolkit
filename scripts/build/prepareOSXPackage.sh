#!/bin/sh
set -e

GTFolder=GToolkitOSX64-$TAG_NAME
mkdir -p $GTFolder
cp -rv GToolkit-64*/* $GTFolder
rm -rf $GTFolder/pharo-local

wget  https://bintray.com/opensmalltalk/vm/download_file?file_path=pharo.cog.spur-cmake-minhdls_macos64x64_201907031959.dmg -O pharo.cog.spur-cmake-minhdls_macos64x64_201907031959.dmg
7z x pharo.cog.spur-cmake-minhdls_macos64x64_201907031959.dmg
mv -fv pharo.cog.spur-cmake-minhdls_macos64x64_201907031959/Pharo.app $GTFolder/

curl https://dl.feenk.com/Glutin/osx/development/x86_64/libGlutin.dylib -o libGlutin.dylib
mv libGlutin.dylib $GTFolder

curl https://dl.feenk.com/Moz2D/osx/development/x86_64/libMoz2D.dylib -o libMoz2D.dylib
mv libMoz2D.dylib $GTFolder

zip -qyr $GTFolder.zip $GTFolder
rm -rf $GTFolder
set +e