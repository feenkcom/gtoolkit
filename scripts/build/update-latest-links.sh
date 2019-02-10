set -o xtrace
set -e
export GTfolder=/var/www/html/gt
find $GTfolder/GToolkitWin64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > GToolkitWin64-release
find $GTfolder/GToolkitOSX64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > GToolkitOSX64-release
find $GTfolder/GToolkitLinux64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > GToolkitLinux64-release
find $GTfolder/GToolkit-64-*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > GToolkit-latest-build
find $GTfolder/GToolkit-64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > GToolkit-latest-tag
set +e