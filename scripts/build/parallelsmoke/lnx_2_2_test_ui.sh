#!/bin/sh
set -o xtrace
echo 'cleanup previous test results'
timeout 6m xvfb-run -a ./GToolkitLinux64/gtoolkit GToolkitLinux64/GToolkit-64-*.image examples --interactive --no-quit --junit-xml-output  'GToolkit-Coder-Examples'

