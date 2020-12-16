#!/bin/sh
set -o xtrace
set -e
ssh-add -K /Users/tudor/.ssh/id_rsa
ls -al ./GlamorousToolkitOSX64*/

echo "${SUDO}" | sudo -S /usr/local/bin/timeout 16m ./GlamorousToolkitOSX64*/GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkitOSX64*/GlamorousToolkit.image eval --save "GlutinLibrary uniqueInstance macModuleName"
echo "${SUDO}" | sudo -S /usr/local/bin/timeout 16m ./GlamorousToolkitOSX64*/GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkitOSX64*/GlamorousToolkit.image eval --save "IceCredentialsProvider sshCredentials publicKey: '/Users/tudor/.ssh/id_rsa.pub'; privateKey: '/Users/tudor/.ssh/id_rsa'. IceCredentialsProvider useCustomSsh: true." 
echo "${SUDO}" | sudo -S /usr/local/bin/timeout 16m ./GlamorousToolkitOSX64*/GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkitOSX64*/GlamorousToolkit.image dedicatedReleaseBranchExamples --junit-xml-output
echo "${SUDO}" | sudo -S /usr/local/bin/timeout 6m ./GlamorousToolkitOSX64*/GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkitOSX64*/GlamorousToolkit.image dedicatedReleaseBranchSlides --junit-xml-output