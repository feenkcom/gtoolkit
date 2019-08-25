#!/bin/sh
set -e
GTFolder=GToolkitLinux64-$TAG_NAME
mkdir -p $GTFolder
cp -rv GToolkit-64*/* $GTFolder
rm -rf $GTFolder/pharo-local

# wget https://bintray.com/opensmalltalk/vm/download_file?file_path=pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201908070737.tar.gz -O pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201908070737.tar.gz
# tar xvzf pharo.cog.spur-cmake-minhdls_linux64x64_itimer_201908070737.tar.gz
# mv -fv phcogspurlinuxmhdls64/* $GTFolder/

# curl https://files.pharo.org/get-files/80/pharo64-linux-headless-latest.zip -o pharo64-linux-headless-latest.zip 
# unzip pharo64-linux-headless-latest.zip  -d $GTFolder/

curl https://dl.feenk.com/gtvm/PharoLinux64.zip
unzip PharoLinux64.zip -d $GTFolder/


curl https://dl.feenk.com/Glutin/linux/development/x86_64/libGlutin.so -o libGlutin.so
mv libGlutin.so $GTFolder

curl https://dl.feenk.com/Moz2D/linux/development/x86_64/libMoz2D.so -o libMoz2D.so
mv libMoz2D.so $GTFolder

curl https://dl.feenk.com/Clipboard/linux/development/x86_64/libClipboard.so -o libClipboard.so
mv libClipboard.so $GTFolder


zip -qyr $GTFolder.zip $GTFolder
rm -rf $GTFolder
set +e