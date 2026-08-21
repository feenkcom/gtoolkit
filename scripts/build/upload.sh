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

# Remove the oldest 40 releases.
# The GlamorousToolkit*-release and *-release.zip files are the stable entry points used by the
# download page and by scripts/rollback/rollback.sh, so they are never deletion candidates. Without
# this they survive only as long as every platform keeps refreshing them on every release.
ssh "$AWS" -t "cd ${GT_FOLDER}; ls -tp | grep -v '/$' | grep -v -- '-release' | tail -n +40 | xargs -d '\n' -r rm --"

# Deploy local build scripts (Mac, Linux and Windows)
scp scripts/localbuild/*.sh "$AWS:$SCRIPTS_FOLDER"
scp scripts/localbuild/*.ps1 "$AWS:$SCRIPTS_FOLDER"

pwd
set +e
