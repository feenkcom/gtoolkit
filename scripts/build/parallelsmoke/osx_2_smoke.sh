#!/bin/sh
set -o xtrace
GToolkitOSX64-"${TAG_NAME}"/GToolkit.app/Contents/MacOS/GToolkit GToolkitOSX64-"${TAG_NAME}"/GToolkit-64-*.image eval "1+2"
