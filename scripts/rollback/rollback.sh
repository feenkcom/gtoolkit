#!/bin/bash
set -o xtrace
set -e

export GTfolder=/var/www/html/gt

cd $GTfolder

version=$(cat $GTfolder/GlamorousToolkitWin64-release)
vn="$(cut -d '.' -f3 <<<$version)"
previous="$(($vn - 1))"
sed -i "s/${vn}/${previous}/g" $GTfolder/GlamorousToolkitWin64-release
version=$(cat $GTfolder/GlamorousToolkitWin64-release)
cp $version $GTfolder/GlamorousToolkitWin64-release.zip

version=$(cat $GTfolder/GlamorousToolkitOSX64-release)
vn="$(cut -d '.' -f3 <<<$version)"
previous="$(($vn - 1))"
sed -i "s/${vn}/${previous}/g" $GTfolder/GlamorousToolkitOSX64-release
version=$(cat $GTfolder/GlamorousToolkitOSX64-release)
cp $version $GTfolder/GlamorousToolkitOSX64-release.zip

version=$(cat $GTfolder/GlamorousToolkitLinux64-release)
vn="$(cut -d '.' -f3 <<<$version)"
previous="$(($vn - 1))"
sed -i "s/${vn}/${previous}/g" $GTfolder/GlamorousToolkitLinux64-release
version=$(cat $GTfolder/GlamorousToolkitLinux64-release)
cp $version $GTfolder/GlamorousToolkitLinux64-release.zip


stat -c %Y "$(cat $GTfolder/GlamorousToolkitLinux64-release)" > .releasedateinseconds
cd -

set +e