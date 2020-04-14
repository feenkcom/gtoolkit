#!/bin/bash
set -o xtrace
set -e

export GTfolder=/var/www/html/gt

version=$(cat $GTfolder/GToolkitWin64-release)
vn="$(cut -d '.' -f3 <<<$version)"
previous="$(($vn - 1))"
sed -i "s/${vn}/${previous}/g" $GTfolder/GToolkitWin64-release
version=$(cat $GTfolder/GToolkitWin64-release)
cp $version $GTfolder/GToolkitWin64-release.zip

version=$(cat $GTfolder/GToolkitOSX64-release)
vn="$(cut -d '.' -f3 <<<$version)"
previous="$(($vn - 1))"
sed -i "s/${vn}/${previous}/g" $GTfolder/GToolkitOSX64-release
version=$(cat $GTfolder/GToolkitOSX64-release)
cp $version $GTfolder/GToolkitOSX64-release.zip

version=$(cat $GTfolder/GToolkitLinux64-release)
vn="$(cut -d '.' -f3 <<<$version)"
previous="$(($vn - 1))"
sed -i "s/${vn}/${previous}/g" $GTfolder/GToolkitLinux64-release
version=$(cat $GTfolder/GToolkitLinux64-release)
cp $version $GTfolder/GToolkitLinux64-release.zip

cd $GTfolder
stat -c %Y "$(cat $GTfolder/GToolkitLinux64-release)" > .releasedateinseconds
cd -

set +e