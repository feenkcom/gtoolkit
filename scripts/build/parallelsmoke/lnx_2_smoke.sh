#!/bin/sh
set -o xtrace

#xvfb-run -a -e /dev/stdout ./GToolkitLinux64/gtoolkit GToolkitLinux64/GToolkit-64-*.image examples --interactive --no-quit --junit-xml-output  'GToolkit-Coder-Examples' 'GToolkit-.*' 'GT4SmaCC-.*' 'DeepTraverser-.*' 'Brick' 'Brick-.*' 'Bloc' 'Bloc-.*' 'Sparta-.*'
#xvfb-run -a -e /dev/stdout ./GToolkitLinux64/gtoolkit GToolkitLinux64/GToolkit-64-*.image gtexportreport --report=GtGtoolkitArchitecturalReport

#run smoke tests
timeout 60 xvfb-run -a ./GToolkitLinux64/gtoolkit GToolkitLinux64/GToolkit-64-*.image --interactive &
sleep 50
export DISPLAY=$(ps -aux | grep screen -m 1 | awk '{print $12}')
export XAUTHORITY=$(ps -aux | grep screen -m 1 | awk '{print $19}')
# It is enough to specify -root to take a screenshot of the main screen
xwd -display $DISPLAY -root -out gt.xwd
convert -verbose gt.xwd gt.jpg

if [ $(find gt.jpg -type f -size +20000c 2>/dev/null) ] 
then
    echo "Screenshot looking good."
else 
    ls -al
    echo "gt.jpg does not exist or is too small. Exiting with 1 in order to fail the build."
    exit 1
fi
