#!/bin/sh
set -e
set -o xtrace
GTFolder=GToolkitWin64-$TAG_NAME
mkdir -p $GTFolder
cp -rv GToolkit-64*/* $GTFolder
rm -rf $GTFolder/pharo-local


libFolder=libWin64-$TAG_NAME
mkdir -p $libFolder


curl https://dl.feenk.com/gtvm/GToolkitVM-8.2.0-ea61a04db-win64-bin.zip -o GToolkitVM-8.2.0-ea61a04db-win64-bin.zip
unzip GToolkitVM-8.2.0-ea61a04db-win64-bin.zip
mv GToolkitVM-8.2.0-ea61a04db-win64-bin/* $GTFolder/

# curl https://files.pharo.org/get-files/80/pharo64-win-headless-latest.zip -o pharo64-win-headless-latest.zip
# unzip pharo64-win-headless-latest.zip -d $GTFolder/

# wget https://bintray.com/opensmalltalk/vm/download_file?file_path=pharo.cog.spur-cmake-minhdls_win64x64_201908212333.zip -O pharo.cog.spur-cmake-minhdls_win64x64_201908212333.zip
# unzip pharo.cog.spur-cmake-minhdls_win64x64_201908212333.zip -d pharo64-win-stable
# mv -fv pharo64-win-stable/* $GTFolder/

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
