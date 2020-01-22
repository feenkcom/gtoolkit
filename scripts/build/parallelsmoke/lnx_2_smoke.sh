#!/bin/sh
set -o xtrace
TAG_NAME=$( cat tagname.txt )
xvfb-run -a -e /dev/stdout ./GToolkitLinux64-"${TAG_NAME}"/gtoolkit GToolkitLinux64-"${TAG_NAME}"/GToolkit-64-*.image examples --junit-xml-output 'GToolkit-Coder-Examples'