#!/bin/sh
set -e
TAG_NAME=$( cat tagname.txt )
GTFolder=GToolkitOSX64-$TAG_NAME
mkdir -p $GTFolder

libFolder=libOSX64-$TAG_NAME
mkdir -p $libFolder

unzip build-artifacts/GToolkitVM-8.2.0-*-mac64-bin.zip -d $GTFolder/

cp -rv GToolkit-64*/* $GTFolder
rm -rf $GTFolder/pharo-local


package_binary() {
	curl https://dl.feenk.com/$1/osx/development/x86_64/lib$1.dylib -o lib$1.dylib
	cp lib$1.dylib $GTFolder
	cp lib$1.dylib $libFolder
}

package_binary Boxer
package_binary Gleam
package_binary Glutin
package_binary Clipboard
package_binary Skia

zip -qyr $GTFolder.zip $GTFolder
zip -qyr $libFolder.zip $libFolder
rm -rf $GTFolder
rm -rf $libFolder
set +e
