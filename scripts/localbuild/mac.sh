#/bin/sh!
set -o xtrace

# find . ! -name '*.st' ! -name '*.sh' ! -name '.' -exec rm -rf {} +

wget https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/loadgt.st -O loadgt.st

curl https://get.pharo.org/64/80 | bash

wget https://github.com/feenkcom/opensmalltalk-vm/releases/latest/download/build-artifacts.zip -O build-artifacts.zip
unzip build-artifacts.zip
unzip build-artifacts/GlamorousToolkitVM-8.2.0-*-mac64-bin.zip

time ./GToolkit.app/Contents/MacOS/GToolkit Pharo.image st --quit loadgt.st 2>&1

echo "ThreadedFFIMigration enableThreadedFFI. Smalltalk snapshot: true andQuit: true."  > tffi.st
echo "GtWorld openWithShutdownListener. 30 seconds wait. BlHost pickHost universe snapshot: true andQuit: true." > gtworld.st
./GToolkit.app/Contents/MacOS/GToolkit Pharo.image st tffi.st
./GToolkit.app/Contents/MacOS/GToolkit Pharo.image st gtworld.st --interactive --no-quit 
./GToolkit.app/Contents/MacOS/GToolkit Pharo.image --no-quit --interactive

exit 0
