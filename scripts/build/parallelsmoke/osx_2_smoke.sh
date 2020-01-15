#!/bin/sh
set -o xtrace
echo "${SUDO}" | sudo -S ./GToolkitOSX64-"${TAG_NAME}"/GToolkit.app/Contents/MacOS/GToolkit GToolkitOSX64-"${TAG_NAME}"/GToolkit-64-*.image examples --junit-xml-output 'GToolkit-Coder-Examples'
