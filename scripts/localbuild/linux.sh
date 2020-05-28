#/bin/sh!
set -o xtrace

# find . ! -name '*.st' ! -name '*.sh' ! -name '.' -exec rm -rf {} +

curl -L https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/tffi.st -o tffi.st

./glamoroustoolkit Pharo.image st tffi.st --save --quit

curl -L https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/loadgt.st -o loadgt.st

curl https://get.pharo.org/64/80 | bash

curl -L https://github.com/feenkcom/opensmalltalk-vm/releases/latest/download/build-artifacts.zip -o build-artifacts.zip
unzip build-artifacts.zip
unzip build-artifacts/GlamorousToolkitVM-8.2.0-*-linux64-bin.zip

time ./glamoroustoolkit Pharo.image st --quit loadgt.st 2>&1

echo "GtWorld openWithShutdownListener. 30 seconds wait. BlHost pickHost universe snapshot: true andQuit: true." > gtworld.st

./glamoroustoolkit Pharo.image st gtworld.st --interactive --no-quit 
./glamoroustoolkit Pharo.image Pharo.image --no-quit --interactive
