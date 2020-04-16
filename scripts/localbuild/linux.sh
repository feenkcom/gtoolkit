#/bin/sh!
set -o xtrace

# find . ! -name '*.st' ! -name '*.sh' ! -name '.' -exec rm -rf {} +

wget https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/tffi.st -O tffi.st

./gtoolkit Pharo.image st tffi.st --save --quit

wget https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/loadgt.st -O loadgt.st

curl https://get.pharo.org/64/80 | bash

wget https://github.com/feenkcom/opensmalltalk-vm/releases/latest/download/build-artifacts.zip -O build-artifacts.zip
unzip build-artifacts.zip
unzip build-artifacts/GlamorousToolkitVM-8.2.0-*-linux64-bin.zip

time ./gtoolkit Pharo.image st --quit loadgt.st 2>&1

echo "GtWorld openWithShutdownListener. 30 seconds wait. BlHost pickHost universe snapshot: true andQuit: true." > gtworld.st

./gtoolkit Pharo.image st gtworld.st --interactive --no-quit 
./gtoolkit Pharo.image Pharo.image --no-quit --interactive
