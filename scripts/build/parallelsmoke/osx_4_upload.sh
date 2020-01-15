#!/bin/sh
set -o xtrace

export AWS=ubuntu@$AWSIP
export GTfolder=/var/www/html/gt/

scp GToolkitOSX64*.zip $AWS:$GTfolder
echo "${SUDO}" | sudo -S rm -rf GToolkitOSX64-*