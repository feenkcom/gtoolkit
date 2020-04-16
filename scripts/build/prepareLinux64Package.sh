#!/bin/sh
set -e
set -o xtrace
GTFolder=GToolkitLinux64
mkdir -p $GTFolder
cp -rv GToolkit-64*/* $GTFolder
rm -rf $GTFolder/pharo-local

TAG_NAME=$(cat tagname.txt)

libZipFilename=libLinux64
libFolder=libLinux64-$TAG_NAME
mkdir -p $libFolder

unzip build-artifacts/GToolkitVM-8.2.0-*-linux64-bin.zip -d $GTFolder/

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

zip -qyr $libZipFilename.zip $libFolder
zip -qyr $GTFolder.zip $GTFolder
rm -rf $libFolder
rm -rf $GTFolder
set +e
