#!/bin/sh
set -e
set -o xtrace
GTFolder=GlamorousToolkitWin64
mkdir -p $GTFolder
cp -rv GlamorousToolkit-64*/* $GTFolder
rm -rf $GTFolder/pharo-local

libFolder=libWin64
mkdir -p $libFolder

unzip build-artifacts/GlamorousToolkitVM-8.2.0-*-win64-bin.zip -d $GTFolder/

package_binary() {
	curl https://dl.feenk.com/$1/windows/development/x86_64/lib$1.dll -o lib$1.dll
	cp lib$1.dll $GTFolder
	cp lib$1.dll $libFolder
}

package_extra_moz2d_binary() {
	curl https://dl.feenk.com/Moz2D/windows/development/x86_64/$1.dll -o $1.dll
	cp $1.dll $GTFolder
	cp $1.dll $libFolder
}

package_binary Boxer
package_binary Gleam
package_binary Glutin
package_binary Skia
package_extra_moz2d_binary msvcp140
package_extra_moz2d_binary vcruntime140
package_binary Clipboard

zip -qyr $GTFolder.zip $GTFolder
zip -qyr $libFolder.zip $libFolder
rm -rf $GTFolder
rm -rf $libFolder
set +e
