set -o xtrace
set -e
export GTfolder=/var/www/html/gt
ln -fvs `ls -rt $GTfolder/GToolkitWin64*.zip | tail -n 1` $GTfolder/GToolkitWin64-release.zip
ln -fvs `ls -rt $GTfolder/GToolkitOSX64*.zip | tail -n 1` $GTfolder/GToolkitOSX64-release.zip
ln -fvs `ls -rt $GTfolder/GToolkitLinux64*.zip | tail -n 1` $GTfolder/GToolkitLinux64-release.zip
ln -fvs `ls -rt $GTfolder/GToolkit-64-*.zip | tail -n 1` $GTfolder/GToolkit-latest-build.zip
ln -fvs `ls -rt $GTfolder/GToolkit-64-v*.zip | tail -n 1` $GTfolder/GToolkit-latest-tag.zip
set +e