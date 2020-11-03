#!/bin/sh
set -o xtrace
set -e
echo 'cleanup previous test results'
rm -rf *.xml
ldd ./GlamorousToolkitLinux64*/libSkia.so
timeout 6m xvfb-run -a ./GlamorousToolkitLinux64*/glamoroustoolkit GlamorousToolkitLinux64*/GlamorousToolkit.image dedicatedReleaseBranchExamples --junit-xml-output
timeout 6m xvfb-run -a ./GlamorousToolkitLinux64*/glamoroustoolkit GlamorousToolkitLinux64*/GlamorousToolkit.image slides --junit-xml-output $EXAMPLE_PACKAGES
timeout 6m xvfb-run -a ./GlamorousToolkitLinux64*/glamoroustoolkit GlamorousToolkitLinux64*/GlamorousToolkit.image gtexportreport --report=GtGtoolkitArchitecturalReport

