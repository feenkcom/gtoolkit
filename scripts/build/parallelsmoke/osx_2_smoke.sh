#!/bin/sh
set -o xtrace
echo "${SUDO}" | sudo -S ./GToolkitOSX64/GToolkit.app/Contents/MacOS/GToolkit GToolkitOSX64/GToolkit-64-*.image examples --junit-xml-output 'GToolkit-Coder-Examples' 'GToolkit-.*' 'DeepTraverser-.*' 'Brick' 'Brick-.*' 'Bloc' 'Bloc-.*' 'Sparta-.*'

