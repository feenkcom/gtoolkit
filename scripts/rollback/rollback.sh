#!/bin/bash
set -e

export GTfolder=/var/www/html/gt

cd $GTfolder

function rollback {
        local release_archive_name=$(cat $GTfolder/GlamorousToolkit$1-release)
        local yank_version_number="$(cut -d '.' -f3 <<< $release_archive_name)"
        local rollback_version="$($yank_version_number - 1)"

        echo "[$1] We yank $yank_version_number and rollback to $rollback_version"

        # The following replaces the path to the release archive in the release file
        sed -i "s/${yank_version_number}/${rollback_version}/g" "$GTfolder/GlamorousToolkit$1-release"

        local rollback_archive_name=$(cat $GTfolder/GlamorousToolkit$1-release)
        cp -rf "$rollback_archive_name" "$GTfolder/GlamorousToolkit$1-release.zip"
}

rollback "Win64"
rollback "OSX64"
rollback "OSXM1"
rollback "Linux64"

stat -c %Y "$(cat $GTfolder/GlamorousToolkitLinux64-release)" > .releasedateinseconds

set +e