#!/bin/sh
set -o xtrace
./GToolkitLinux64-"${TAG_NAME}"/gtoolkit GToolkit-64-*.image eval "1+2"