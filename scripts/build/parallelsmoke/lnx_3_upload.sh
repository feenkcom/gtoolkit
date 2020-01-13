#!/bin/sh
set -o xtrace

export AWS=ubuntu@ec2-35-157-37-37.eu-central-1.compute.amazonaws.com 
export GTfolder=/var/www/html/gt/

mv GToolkitLinux64.zip GToolkitLinux64-"${TAG_NAME}".zip 

scp GToolkitLinux64-"${TAG_NAME}".zip $AWS:$GTfolder
rm -rf GToolkitLinux64-*