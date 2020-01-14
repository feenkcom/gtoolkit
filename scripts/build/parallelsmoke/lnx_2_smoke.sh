#!/bin/sh
set -o xtrace
xvfb-run -a -e /dev/stdout ./GToolkitLinux64-"${TAG_NAME}"/gtoolkit GToolkitLinux64-"${TAG_NAME}"/GToolkit-64-*.image eval "1+2"