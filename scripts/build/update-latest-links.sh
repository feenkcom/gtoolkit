set -o xtrace
set -e
GT_FOLDER=/var/www/html/gt

find $GT_FOLDER/GlamorousToolkit-Windows-x86_64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > "$GT_FOLDER/GlamorousToolkitWin64-release"
find $GT_FOLDER/GlamorousToolkit-Windows-x86_64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} "$GT_FOLDER/GlamorousToolkitWin64-release.zip"

find $GT_FOLDER/GlamorousToolkit-Windows-aarch64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > "$GT_FOLDER/GlamorousToolkitWinArm64-release"
find $GT_FOLDER/GlamorousToolkit-Windows-aarch64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} "$GT_FOLDER/GlamorousToolkitWinArm64-release.zip"

find $GT_FOLDER/GlamorousToolkit-MacOS-x86_64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > "$GT_FOLDER/GlamorousToolkitOSX64-release"
find $GT_FOLDER/GlamorousToolkit-MacOS-x86_64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} "$GT_FOLDER/GlamorousToolkitOSX64-release.zip"

find $GT_FOLDER/GlamorousToolkit-MacOS-aarch64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > "$GT_FOLDER/GlamorousToolkitOSXM1-release"
find $GT_FOLDER/GlamorousToolkit-MacOS-aarch64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} "$GT_FOLDER/GlamorousToolkitOSXM1-release.zip"

find $GT_FOLDER/GlamorousToolkit-Linux-x86_64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > "$GT_FOLDER/GlamorousToolkitLinux64-release"
find $GT_FOLDER/GlamorousToolkit-Linux-x86_64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} "$GT_FOLDER/GlamorousToolkitLinux64-release.zip"

find $GT_FOLDER/GlamorousToolkit-Linux-aarch64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > "$GT_FOLDER/GlamorousToolkitLinuxArm64-release"
find $GT_FOLDER/GlamorousToolkit-Linux-aarch64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} "$GT_FOLDER/GlamorousToolkitLinuxArm64-release.zip"

set +e