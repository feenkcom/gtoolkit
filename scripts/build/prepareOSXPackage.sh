#!/bin/sh
set -e

GTFolder=GToolkitOSX64-$TAG_NAME
mkdir -p $GTFolder

libFolder=libOSX64-$TAG_NAME
mkdir -p $libFolder

# curl http://files.pharo.org/get-files/80/pharo64-mac-headless-latest.zip -o pharo64-mac-headless-latest.zip
# unzip pharo64-mac-headless-latest.zip -d $GTFolder/

curl https://dl.feenk.com/gtvm/PharoVM-8.1.0-4a6a3adc5-mac64-bin.zip -o PharoVM-8.1.0-4a6a3adc5-mac64-bin.zip
unzip PharoVM-8.1.0-4a6a3adc5-mac64-bin.zip -d $GTFolder/

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
package_binary Moz2D
package_binary Clipboard
package_binary Skia

zip -qyr $GTFolder.zip $GTFolder
zip -qyr $libFolder.zip $libFolder
rm -rf $GTFolder
rm -rf $libFolder
set +e
