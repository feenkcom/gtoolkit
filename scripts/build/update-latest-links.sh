set -o xtrace
set -e
export GTfolder=/var/www/html/gt
ln -fvs `find $GTfolder/GToolkitWin64* -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2` $GTfolder/GToolkitWin64-release.zip
ln -fvs `find $GTfolder/GToolkitOSX64* -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2` $GTfolder/GToolkitOSX64-release.zip
ln -fvs `find $GTfolder/GToolkitLinux64* -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2` $GTfolder/GToolkitLinux64-release.zip
ln -fvs `find $GTfolder/GToolkit-64-* -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2` $GTfolder/GToolkit-latest-build.zip
ln -fvs `find $GTfolder/GToolkit-64-v* -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2` $GTfolder/GToolkit-latest-tag.zip

find $GTfolder/GToolkitWin64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > GToolkitWin64-release
find $GTfolder/GToolkitOSX64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > GToolkitOSX64-release
find $GTfolder/GToolkitLinux64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > GToolkitLinux64-release
find $GTfolder/GToolkit-64-*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > GToolkit-latest-build
find $GTfolder/GToolkit-64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > GToolkit-latest-tag
set +e