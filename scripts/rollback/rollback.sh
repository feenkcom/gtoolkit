#!/bin/bash
set -o xtrace
set -e

export GTfolder=/var/www/html/gt

version=$(cat $GTfolder/GToolkitWin64-release)
vn="$(cut -d '.' -f3 <<<$version)"
previous="$(($vn - 1))"
sed -i "s/${vn}/${previous}/g" $GTfolder/GToolkitWin64-release

version=$(cat $GTfolder/GToolkitOSX64-release)
vn="$(cut -d '.' -f3 <<<$version)"
previous="$(($vn - 1))"
sed -i "s/${vn}/${previous}/g" $GTfolder/GToolkitOSX64-release

version=$(cat $GTfolder/GToolkitLinux64-release)
vn="$(cut -d '.' -f3 <<<$version)"
previous="$(($vn - 1))"
sed -i "s/${vn}/${previous}/g" $GTfolder/GToolkitLinux64-release

set +e