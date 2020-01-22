#/bin/sh!
set -o xtrace

# find . ! -name '*.st' ! -name '*.sh' ! -name '.' -exec rm -rf {} +

wget https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/loadgt.st -O loadgt.st

wget https://files.pharo.org/image/80/Pharo8.0-SNAPSHOT.build.1116.sha.e967f28.arch.64bit.zip -O Pharo8.0-SNAPSHOT.build.1116.sha.e967f28.arch.64bit.zip
unzip Pharo8.0-SNAPSHOT.build.1116.sha.e967f28.arch.64bit.zip
mv Pharo8.0-SNAPSHOT-64bit-*.image Pharo.image
mv Pharo8.0-SNAPSHOT-64bit-*.changes Pharo.changes

wget https://github.com/feenkcom/opensmalltalk-vm/releases/latest/download/build-artifacts.zip -O build-artifacts.zip
unzip build-artifacts.zip
unzip build-artifacts/GToolkitVM-8.2.0-*-mac64-bin.zip

time ./GToolkit.app/Contents/MacOS/GToolkit Pharo.image st --quit loadgt.st 2>&1

./GToolkit.app/Contents/MacOS/GToolkit Pharo.image eval --save "ThreadedFFIMigration enableThreadedFFI." 
./GToolkit.app/Contents/MacOS/GToolkit Pharo.image eval --interactive --no-quit "GtWorld openWithShutdownListener. 30 seconds wait. BlHost pickHost universe snapshot: true andQuit: true."
./GToolkit.app/Contents/MacOS/GToolkit Pharo.image

exit 0