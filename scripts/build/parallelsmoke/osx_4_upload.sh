#!/bin/sh
set -o xtrace

export AWS=ubuntu@$AWSIP
export GTfolder=/var/www/html/tentative/

scp GToolkitOSX64.zip $AWS:$GTfolder
