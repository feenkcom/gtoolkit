#!/bin/sh
set -o xtrace

export AWS=ubuntu@$AWSIP
export GTfolder=/var/www/html/gt/
TAG_NAME=$( cat tagname.txt )

mv GToolkitLinux64.zip GToolkitLinux64-"${TAG_NAME}".zip 

scp GToolkitLinux64-"${TAG_NAME}".zip $AWS:$GTfolder
scp gt.jpg $AWS:$GTfolder
rm -rf GToolkitLinux64-*