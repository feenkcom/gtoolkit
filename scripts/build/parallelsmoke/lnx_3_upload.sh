#!/bin/sh
set -o xtrace

export AWS=ubuntu@AWSIP
export GTfolder=/var/www/html/gt/

mv GToolkitLinux64.zip GToolkitLinux64-"${TAG_NAME}".zip 

scp GToolkitLinux64-"${TAG_NAME}".zip $AWS:$GTfolder
rm -rf GToolkitLinux64-*