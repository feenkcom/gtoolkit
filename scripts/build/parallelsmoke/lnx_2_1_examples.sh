#!/bin/sh
set -o xtrace
set -e
echo 'cleanup previous test results'
rm -rf *.xml
ldd ./GlamorousToolkitLinux64*/libSkia.so
timeout 6m xvfb-run -a ./GlamorousToolkitLinux64*/glamoroustoolkit GlamorousToolkitLinux64*/GlamorousToolkit.image examples --junit-xml-output 'GToolkit-.*' 'GT4SmaCC-.*' 'DeepTraverser-.*' 'Brick' 'Brick-.*' 'Bloc' 'Bloc-.*' 'Sparta-.*'
timeout 6m xvfb-run -a ./GlamorousToolkitLinux64*/glamoroustoolkit GlamorousToolkitLinux64*/GlamorousToolkit.image slides --junit-xml-output 'GToolkit-.*' 'GT4SmaCC-.*' 'DeepTraverser-.*' 'Brick' 'Brick-.*' 'Bloc' 'Bloc-.*' 'Sparta-.*'
timeout 6m xvfb-run -a ./GlamorousToolkitLinux64*/glamoroustoolkit GlamorousToolkitLinux64*/GlamorousToolkit.image gtexportreport --report=GtGtoolkitArchitecturalReport

