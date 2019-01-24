set -o xtrace
set -e
export GTfolder=/var/www/html/gt
ln -fvs `ls -rt $GTfolder/GToolkitWin64* | tail -n 1` $GTfolder/GToolkitWin64-release
ln -fvs `ls -rt $GTfolder/GToolkitOSX64* | tail -n 1` $GTfolder/GToolkitOSX64-release
ln -fvs `ls -rt $GTfolder/GToolkitLinux64* | tail -n 1` $GTfolder/GToolkitLinux64-release
ln -fvs `ls -rt $GTfolder/GToolkit-64-* | tail -n 1` $GTfolder/GToolkit-latest-build
ln -fvs `ls -rt $GTfolder/GToolkit-64-v* | tail -n 1` $GTfolder/GToolkit-latest-tag
set +e