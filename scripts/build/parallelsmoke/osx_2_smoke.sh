#!/bin/sh
set -o xtrace
set -e
echo "${SUDO}" | sudo -S /usr/local/bin/timeout 6m ./GToolkitOSX64/GToolkit.app/Contents/MacOS/GToolkit GToolkitOSX64/GToolkit-64-*.image examples --junit-xml-output 'GToolkit-Coder-Examples' 'GToolkit-.*' 'GT4SmaCC-.*' 'DeepTraverser-.*' 'Brick' 'Brick-.*' 'Bloc' 'Bloc-.*' 'Sparta-.*'
