#!/bin/sh
set -o xtrace
set -e
export AWS=ubuntu@$AWSIP
export GTfolder=/var/www/html/tentative/

scp GlamorousToolkitOSX64.zip $AWS:$GTfolder
