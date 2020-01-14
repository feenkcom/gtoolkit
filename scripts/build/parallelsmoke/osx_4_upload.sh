#!/bin/sh
set -o xtrace

export AWS=ubuntu@ec2-35-157-37-37.eu-central-1.compute.amazonaws.com 
export GTfolder=/var/www/html/gt/

scp GToolkitOSX64*.zip $AWS:$GTfolder
rm -rf GToolkitOSX64-*