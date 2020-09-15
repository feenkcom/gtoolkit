#/bin/sh!
set -o xtrace

# find . ! -name '*.st' ! -name '*.sh' ! -name '.' -exec rm -rf {} +

curl -L https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/loadgt.st -o loadgt.st

curl https://get.pharo.org/64/80 | bash

curl -L https://github.com/feenkcom/opensmalltalk-vm/releases/latest/download/build-artifacts.zip -o build-artifacts.zip
unzip build-artifacts.zip
unzip build-artifacts/GlamorousToolkitVM-*-linux64-bin.zip

time ./glamoroustoolkit Pharo.image st --quit loadgt.st 2>&1

echo "ThreadedFFIMigration enableThreadedFFI. Smalltalk snapshot: true andQuit: true."  > tffi.st
echo "GtWorld openDefault. 2 seconds wait. BlHost pickHost universe snapshot: true andQuit: true." > gtworld.st
./glamoroustoolkit Pharo.image st tffi.st
./glamoroustoolkit Pharo.image st gtworld.st --interactive --no-quit 
echo "Setup process complete. To start GlamorousToolkit run \n ./glamoroustoolkit Pharo.image --no-quit --interactive"


exit 0
