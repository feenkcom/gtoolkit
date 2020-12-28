#!/bin/sh
set -e
set -o xtrace

TAG_NAME=$(cat tagname.txt) 
GTFolderZip=GlamorousToolkitOSX64
GTFolder=$GTFolderZip-$TAG_NAME
mkdir -p $GTFolder

libFolder=libOSX64
mkdir -p $libFolder

unzip build-artifacts/GlamorousToolkitVM-*-mac64-bin.zip -d $GTFolder/

cp -rv GlamorousToolkit/* $GTFolder
rm -rf $GTFolder/pharo-local


package_binary() {
	curl https://dl.feenk.com/$1/osx/development/x86_64/lib$1.dylib -o lib$1.dylib
	cp lib$1.dylib $GTFolder
	cp lib$1.dylib $libFolder
}

package_binary Boxer
package_binary Gleam
package_binary Glutin
package_binary Winit
package_binary Metal
package_binary Clipboard
package_binary Skia

zip -qyr $GTFolderZip.zip $GTFolder
zip -qyr $libFolder.zip $libFolder
rm -rf $GTFolder
rm -rf $libFolder
set +e
