#!/bin/sh
set -o xtrace
echo 'cleanup previous test results'
rm -rf *.xml
timeout 6m xvfb-run -a ./GToolkitLinux64/gtoolkit GToolkitLinux64/GToolkit-64-*.image examples --interactive --no-quit --junit-xml-output 'GToolkit-.*' 'GT4SmaCC-.*' 'DeepTraverser-.*' 'Brick' 'Brick-.*' 'Bloc' 'Bloc-.*' 'Sparta-.*'
timeout 6m xvfb-run -a ./GToolkitLinux64/gtoolkit GToolkitLinux64/GToolkit-64-*.image gtexportreport --report=GtGtoolkitArchitecturalReport

