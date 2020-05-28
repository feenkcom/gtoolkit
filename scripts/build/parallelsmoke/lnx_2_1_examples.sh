#!/bin/sh
set -o xtrace
set -e
echo 'cleanup previous test results'
rm -rf *.xml
timeout 6m xvfb-run -a ./GlamorousToolkitLinux64*/glamoroustoolkit GlamorousToolkitLinux64*/GlamorousToolkit-64-*.image examples --interactive --no-quit --junit-xml-output 'GToolkit-.*' 'GT4SmaCC-.*' 'DeepTraverser-.*' 'Brick' 'Brick-.*' 'Bloc' 'Bloc-.*' 'Sparta-.*'
timeout 6m xvfb-run -a ./GlamorousToolkitLinux64*/glamoroustoolkit GlamorousToolkitLinux64*/GlamorousToolkit-64-*.image gtexportreport --report=GtGtoolkitArchitecturalReport

