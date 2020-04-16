set -o xtrace
set -e
export GTfolder=/var/www/html/gt
find $GTfolder/GlamorousToolkitWin64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > $GTfolder/GlamorousToolkitWin64-release
find $GTfolder/GlamorousToolkitWin64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} $GTfolder/GlamorousToolkitWin64-release.zip

find $GTfolder/GlamorousToolkitOSX64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > $GTfolder/GlamorousToolkitOSX64-release
find $GTfolder/GlamorousToolkitOSX64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} $GTfolder/GlamorousToolkitOSX64-release.zip

find $GTfolder/GlamorousToolkitLinux64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > $GTfolder/GlamorousToolkitLinux64-release
find $GTfolder/GlamorousToolkitLinux64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} $GTfolder/GlamorousToolkitLinux64-release.zip

set +e