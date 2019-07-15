#!/bin/sh
set -e
GTFolder=GToolkitLinux64-$TAG_NAME
mkdir -p $GTFolder
cp -rv GToolkit-64*/* $GTFolder
rm -rf $GTFolder/pharo-local

wget https://bintray.com/opensmalltalk/vm/download_file?file_path=pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201907112020.tar.gz -O pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201907112020.tar.gz
tar xvzf pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201907112020.tar.gz
mv -fv xvzf phcogspurlinuxmhdls64/* $GTFolder/

curl https://dl.feenk.com/Glutin/linux/development/x86_64/libGlutin.so -o libGlutin.so
mv libGlutin.so $GTFolder

curl https://dl.feenk.com/Moz2D/linux/development/x86_64/libMoz2D.so -o libMoz2D.so
mv libMoz2D.so $GTFolder

zip -qyr $GTFolder.zip $GTFolder
rm -rf $GTFolder
set +e