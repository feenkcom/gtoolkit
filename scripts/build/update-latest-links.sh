set -o xtrace
set -e
export GTfolder=/var/www/html/gt
find $GTfolder/GToolkitWin64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > $GTfolder/GToolkitWin64-release
find $GTfolder/GToolkitWin64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} $GTfolder/GToolkitWin64-release.zip

find $GTfolder/GToolkitOSX64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > $GTfolder/GToolkitOSX64-release
find $GTfolder/GToolkitOSX64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} $GTfolder/GToolkitOSX64-release.zip

find $GTfolder/GToolkitLinux64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > $GTfolder/GToolkitLinux64-release
find $GTfolder/GToolkitLinux64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} $GTfolder/GToolkitLinux64-release.zip

# find $GTfolder/GToolkit-64-*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > $GTfolder/GToolkit-latest-build
# find $GTfolder/GToolkit-64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > $GTfolder/GToolkit-latest-tag
set +e