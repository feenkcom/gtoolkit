#!/bin/bash
set -o xtrace
set -e
pwd
ls -al
AWS="ubuntu@sftp.feenk.com"
GT_FOLDER=/var/www/html/gt/
SCRIPTS_FOLDER=/var/www/html/scripts/

# Upload released artefacts to https://dl.feenk.com/gt/
scp GlamorousToolkit*.zip "$AWS:$GT_FOLDER"

# Save the date so we can show it in the download button
date +%s > releasedateinseconds
scp releasedateinseconds "$AWS:$GT_FOLDER/.releasedateinseconds"

# Remove the oldest 40 releases
ssh "$AWS" -t "cd ${GT_FOLDER}; ls -tp | grep -v '/$' | tail -n +40 | xargs -d '\n' -r rm --"

# Deploy local build scripts (Mac, Linux and Windows)
scp scripts/localbuild/*.sh "$AWS:$SCRIPTS_FOLDER"
scp scripts/localbuild/*.ps1 "$AWS:$SCRIPTS_FOLDER"

pwd
set +e
