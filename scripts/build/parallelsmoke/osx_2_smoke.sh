#!/bin/sh
set -o xtrace
set -e
echo "${SUDO}" | sudo -S /usr/local/bin/timeout 16m ./GlamorousToolkitOSX64*/GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkitOSX64*/GlamorousToolkit.image dedicatedReleaseBranchExamples --junit-xml-output
echo "${SUDO}" | sudo -S /usr/local/bin/timeout 6m ./GlamorousToolkitOSX64*/GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkitOSX64*/GlamorousToolkit.image dedicatedReleaseBranchSlides --junit-xml-output