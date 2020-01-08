#/bin/sh!
set -o xtrace
set -e
sh scripts/build/downloadLatestVM.sh
sh scripts/build/prepareWin64Package.sh
sh scripts/build/prepareOSXPackage.sh
sh scripts/build/prepareLinux64Package.sh
find . -name "GToolkit-64*/*" -print