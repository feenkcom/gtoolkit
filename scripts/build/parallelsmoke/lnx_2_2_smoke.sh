#!/bin/sh
set -o xtrace
set -e
#run smoke tests

#first start gt with a 60 second timeout and put its process in the background with an &
timeout 60 xvfb-run -a ./GlamorousToolkitLinux64*/glamoroustoolkit GlamorousToolkitLinux64*/GlamorousToolkit.image --interactive &

#then sleep for 50 seconds so that gt has time to boot and settle
sleep 50

#then take a screenshot of the screen
export DISPLAY=$(ps -aux | grep screen -m 1 | awk '{print $12}')
export XAUTHORITY=$(ps -aux | grep screen -m 1 | awk '{print $19}')

# It is enough to specify -root to take a screenshot of the main screen
xwd -display $DISPLAY -root -out gt.xwd
convert -verbose gt.xwd gt.jpg

if [ $(find gt.jpg -type f -size +15000c 2>/dev/null) ] 
then
    echo "Screenshot looking good."
else 
    ls -al
    echo "gt.jpg does not exist or is too small. Exiting with 1 in order to fail the build."
    exit 1
fi
