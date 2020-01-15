#/bin/sh!
set -o xtrace

curl https://dl.feenk.com/tentative/GT.zip -o GT.zip
unzip GT.zip

sh scripts/build/downloadLatestVM.sh	
unzip build-artifacts.zip
