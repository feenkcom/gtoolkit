#!/bin/sh
set -o xtrace
set -e
ssh-add -K /Users/tudor/.ssh/id_rsa
ls -al ./GlamorousToolkitOSX64*/

export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

echo "${SUDO}" | sudo -S timeout 5m ./GlamorousToolkitOSX64*/GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkitOSX64*/GlamorousToolkit.image eval --save "IceCredentialsProvider sshCredentials publicKey: '/Users/tudor/.ssh/id_rsa.pub'; privateKey: '/Users/tudor/.ssh/id_rsa'. IceCredentialsProvider useCustomSsh: true." 
echo "${SUDO}" | sudo -S timeout 30m ./GlamorousToolkitOSX64*/GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkitOSX64*/GlamorousToolkit.image dedicatedReleaseBranchExamples --junit-xml-output --verbose
echo "${SUDO}" | sudo -S timeout 6m ./GlamorousToolkitOSX64*/GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkitOSX64*/GlamorousToolkit.image dedicatedReleaseBranchSlides --junit-xml-output
