#/bin/sh!
set -o xtrace

# find . ! -name '*.st' ! -name '*.sh' ! -name '.' -exec rm -rf {} +

wget https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/loadgt.st -O loadgt.st

curl https://get.pharo.org/64/80 | bash

wget https://github.com/feenkcom/opensmalltalk-vm/releases/latest/download/build-artifacts.zip -O build-artifacts.zip
unzip build-artifacts.zip
unzip build-artifacts/GToolkitVM-8.2.0-*-mac64-bin.zip

time ./GToolkit.app/Contents/MacOS/GToolkit Pharo.image st --quit loadgt.st 2>&1

./GToolkit.app/Contents/MacOS/GToolkit Pharo.image --save eval "ThreadedFFIMigration enableThreadedFFI." 
./GToolkit.app/Contents/MacOS/GToolkit Pharo.image --interactive --no-quit eval "GtWorld openWithShutdownListener. 30 seconds wait. BlHost pickHost universe snapshot: true andQuit: true."
./GToolkit.app/Contents/MacOS/GToolkit Pharo.image --no-quit --interactive

exit 0
