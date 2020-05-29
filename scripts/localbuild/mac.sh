#/bin/sh!
set -o xtrace

# find . ! -name '*.st' ! -name '*.sh' ! -name '.' -exec rm -rf {} +

curl -L https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/loadgt.st -o loadgt.st

curl https://get.pharo.org/64/80 | bash

curl -L https://github.com/feenkcom/opensmalltalk-vm/releases/latest/download/build-artifacts.zip -o build-artifacts.zip
unzip build-artifacts.zip
unzip build-artifacts/GlamorousToolkitVM-8.2.0-*-mac64-bin.zip

time ./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit Pharo.image st --quit loadgt.st 2>&1

echo "ThreadedFFIMigration enableThreadedFFI. Smalltalk snapshot: true andQuit: true."  > tffi.st
echo "GtWorld openWithShutdownListener. 30 seconds wait. BlHost pickHost universe snapshot: true andQuit: true." > gtworld.st
./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit Pharo.image st tffi.st
./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit Pharo.image st gtworld.st --interactive --no-quit 
./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit Pharo.image --no-quit --interactive

exit 0
