set -o xtrace
set -e
GT_FOLDER=/var/www/html/gt

find $GT_FOLDER/GlamorousToolkit-Windows-x86_64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > "$GT_FOLDER/GlamorousToolkitWin64-release"
find $GT_FOLDER/GlamorousToolkit-Windows-x86_64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} "$GT_FOLDER/GlamorousToolkitWin64-release.zip"

find $GT_FOLDER/GlamorousToolkit-Windows-aarch64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > "$GT_FOLDER/GlamorousToolkitWinArm64-release"
find $GT_FOLDER/GlamorousToolkit-Windows-aarch64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} "$GT_FOLDER/GlamorousToolkitWinArm64-release.zip"

# Guard against the glob going unmatched: with no matching zip, "xargs basename" fails, and under
# "set -e" that aborts the whole script, leaving every link below this point stale.
if ls $GT_FOLDER/GlamorousToolkit-MacOS-x86_64*.zip >/dev/null 2>&1; then
    find $GT_FOLDER/GlamorousToolkit-MacOS-x86_64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > "$GT_FOLDER/GlamorousToolkitOSX64-release"
    find $GT_FOLDER/GlamorousToolkit-MacOS-x86_64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} "$GT_FOLDER/GlamorousToolkitOSX64-release.zip"
else
    echo "WARNING: no GlamorousToolkit-MacOS-x86_64*.zip on the server; leaving GlamorousToolkitOSX64-release* unchanged" >&2
fi

find $GT_FOLDER/GlamorousToolkit-MacOS-aarch64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > "$GT_FOLDER/GlamorousToolkitOSXM1-release"
find $GT_FOLDER/GlamorousToolkit-MacOS-aarch64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} "$GT_FOLDER/GlamorousToolkitOSXM1-release.zip"

find $GT_FOLDER/GlamorousToolkit-Linux-x86_64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > "$GT_FOLDER/GlamorousToolkitLinux64-release"
find $GT_FOLDER/GlamorousToolkit-Linux-x86_64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} "$GT_FOLDER/GlamorousToolkitLinux64-release.zip"

find $GT_FOLDER/GlamorousToolkit-Linux-aarch64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs basename > "$GT_FOLDER/GlamorousToolkitLinuxArm64-release"
find $GT_FOLDER/GlamorousToolkit-Linux-aarch64*.zip -type f -printf "%T+\t%p\n" | sort | tail -n 1 | cut -f2 | xargs -i cp {} "$GT_FOLDER/GlamorousToolkitLinuxArm64-release.zip"

set +e