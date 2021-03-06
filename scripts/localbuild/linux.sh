#/bin/sh!
set -o xtrace

# find . ! -name '*.st' ! -name '*.sh' ! -name '.' -exec rm -rf {} +

curl -L https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/loadgt.st -o loadgt.st
curl -L https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/loadice.st -o loadice.st

curl https://get.pharo.org/64/80 | bash

mv Pharo.image GlamorousToolkit.image
mv Pharo.changes GlamorousToolkit.changes

curl -L https://github.com/feenkcom/opensmalltalk-vm/releases/latest/download/build-artifacts.zip -o build-artifacts.zip
unzip build-artifacts.zip
unzip build-artifacts/GlamorousToolkitVM-*-linux64-bin.zip

time ./glamoroustoolkit GlamorousToolkit.image st --quit loadice.st 2>&1
time ./glamoroustoolkit GlamorousToolkit.image st --quit loadgt.st 2>&1

echo "ThreadedFFIMigration enableThreadedFFI. Smalltalk snapshot: true andQuit: true."  > tffi.st
echo "GtWorld openDefault. 5 seconds wait. BlHost pickHost universe snapshot: true andQuit: true." > gtworld.st
./glamoroustoolkit GlamorousToolkit.image st tffi.st
./glamoroustoolkit GlamorousToolkit.image st gtworld.st --interactive --no-quit 
echo "Setup process complete. To start GlamorousToolkit run \n ./glamoroustoolkit GlamorousToolkit.image --no-quit --interactive"


exit 0
