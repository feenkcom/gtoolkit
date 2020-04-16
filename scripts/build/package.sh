#/bin/sh!
set -o xtrace
set -e

TAG_NAME=$(git ls-remote --tags git@github.com:feenkcom/gtoolkit.git | grep /v0 | sort -t '/' -k 3 -V | tail -n1 |sed 's/.*\///; s/\^{}//')
echo $TAG_NAME > tagname.txt

sh scripts/build/prepareWin64Package.sh
sh scripts/build/prepareOSXPackage.sh
sh scripts/build/prepareLinux64Package.sh
find . -name "GlamorousToolkit-64*/*" -print