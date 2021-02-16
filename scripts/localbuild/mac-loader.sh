#/bin/sh!
set -o xtrace

# find . ! -name '*.st' ! -name '*.sh' ! -name '.' -exec rm -rf {} +

curl -L https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/loadgt-loader.st -o loadgt-loader.st

curl https://get.pharo.org/64/80 | bash

mv Pharo.image GlamorousToolkit.image
mv Pharo.changes GlamorousToolkit.changes

curl -L https://github.com/feenkcom/opensmalltalk-vm/releases/latest/download/build-artifacts.zip -o build-artifacts.zip
unzip build-artifacts.zip
unzip build-artifacts/GlamorousToolkitVM-*-mac64-bin.zip

time ./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkit.image st --quit loadgt-loader.st 2>&1

echo "ThreadedFFIMigration enableThreadedFFI. Smalltalk snapshot: true andQuit: true."  > tffi.st
echo "GtWorld openDefault. 5 seconds wait. BlHost pickHost universe snapshot: true andQuit: true." > gtworld.st
./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkit.image st tffi.st
./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkit.image st gtworld.st --interactive --no-quit 
echo "Setup process complete. To start GlamorousToolkit run \n ./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkit.image --no-quit --interactive"

exit 0
