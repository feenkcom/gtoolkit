#!/bin/sh
set -o xtrace
set -e
ssh-add -K /Users/tudor/.ssh/id_rsa
ls -al ./GlamorousToolkitOSX64*/

echo "${SUDO}" | sudo -S gtimeout 5m ./GlamorousToolkitOSX64*/GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkitOSX64*/GlamorousToolkit.image eval --save "IceCredentialsProvider sshCredentials publicKey: '/Users/tudor/.ssh/id_rsa.pub'; privateKey: '/Users/tudor/.ssh/id_rsa'. IceCredentialsProvider useCustomSsh: true." 
echo "${SUDO}" | sudo -S gtimeout 30m ./GlamorousToolkitOSX64*/GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkitOSX64*/GlamorousToolkit.image dedicatedReleaseBranchExamples --junit-xml-output --verbose
echo "${SUDO}" | sudo -S gtimeout 6m ./GlamorousToolkitOSX64*/GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkitOSX64*/GlamorousToolkit.image dedicatedReleaseBranchSlides --junit-xml-output
