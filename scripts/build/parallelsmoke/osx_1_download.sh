#!/bin/sh
set -o xtrace
set -e

curl https://dl.feenk.com/tentative/GlamorousToolkitOSX64.zip -o GlamorousToolkitOSX64.zip
rm -rf GlamorousToolkitLinux64-v0.*
unzip GlamorousToolkitOSX64.zip