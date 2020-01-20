#/bin/sh!
set -o xtrace

mv pharo-local ../

find . ! -name '*.st' ! -name '*.sh' ! -name '.' -exec rm -rf {} +

rm -rf Pharo8.0-SNAPSHOT*
curl https://files.pharo.org/image/80/Pharo8.0-SNAPSHOT.build.1114.sha.2258354.arch.64bit.zip -o Pharo8.0-SNAPSHOT.build.1114.sha.2258354.arch.64bit.zip
unzip Pharo8.0-SNAPSHOT.build.1114.sha.2258354.arch.64bit.zip
mv Pharo8.0-SNAPSHOT-64bit-*.image Pharo.image
mv Pharo8.0-SNAPSHOT-64bit-*.changes Pharo.changes

wget https://github.com/feenkcom/opensmalltalk-vm/releases/latest/download/build-artifacts.zip -O build-artifacts.zip
unzip build-artifacts.zip
unzip build-artifacts/GToolkitVM-8.2.0-*-mac64-bin.zip

time ./GToolkit.app/Contents/MacOS/GToolkit Pharo.image st --quit loadgt.st 2>&1

./GToolkit.app/Contents/MacOS/GToolkit Pharo.image eval --save "ThreadedFFIMigration enableThreadedFFI." 
./GToolkit.app/Contents/MacOS/GToolkit Pharo.image eval --interactive --no-quit "GtWorld openWithShutdownListener. 30 seconds wait. BlHost pickHost universe snapshot: true andQuit: true."


exit 0