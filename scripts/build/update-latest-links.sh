set -o xtrace
set -e
GT_FOLDER=/var/www/html/gt
find $GT_FOLDER/GlamorousToolkitWin64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > $GT_FOLDER/GlamorousToolkitWin64-release
find $GT_FOLDER/GlamorousToolkitWin64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} $GT_FOLDER/GlamorousToolkitWin64-release.zip

find $GT_FOLDER/GlamorousToolkitOSX64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > $GT_FOLDER/GlamorousToolkitOSX64-release
find $GT_FOLDER/GlamorousToolkitOSX64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} $GT_FOLDER/GlamorousToolkitOSX64-release.zip

find $GT_FOLDER/GlamorousToolkitLinux64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > $GT_FOLDER/GlamorousToolkitLinux64-release
find $GT_FOLDER/GlamorousToolkitLinux64-v*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} $GT_FOLDER/GlamorousToolkitLinux64-release.zip

set +e