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

curl https://dl.feenk.com/gtvm/GToolkitVM-8.2.0-ea61a04db-linux64-bin.zip -o GToolkitVM-8.2.0-ea61a04db-linux64-bin.zip
unzip GToolkitVM-8.2.0-ea61a04db-linux64-bin.zip-d $GTFolder/

package_binary() {
	curl https://dl.feenk.com/$1/linux/development/x86_64/lib$1.so -o lib$1.so
	cp lib$1.so $GTFolder
	cp lib$1.so $libFolder
}

package_binary Boxer
package_binary Gleam
package_binary Glutin
package_binary Clipboard
package_binary Skia

zip -qyr $libFolder.zip $libFolder
zip -qyr $GTFolder.zip $GTFolder
rm -rf $libFolder
rm -rf $GTFolder
set +e
