#/bin/sh!
set -o xtrace

# find . ! -name '*.st' ! -name '*.sh' ! -name '.' -exec rm -rf {} +

curl -L https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/loadice.st -o loadice.st
curl -L https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/loadgt.st -o loadgt.st

curl https://get.pharo.org/64/80 | bash

curl -L https://github.com/feenkcom/opensmalltalk-vm/releases/latest/download/build-artifacts.zip -o build-artifacts.zip
unzip build-artifacts.zip
unzip build-artifacts/GlamorousToolkitVM-*-mac64-bin.zip

mv Pharo.image GlamorousToolkit.image
mv Pharo.changes GlamorousToolkit.changes

time ./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkit.image st --quit loadice.st 2>&1
time ./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkit.image st --quit loadgt.st 2>&1

EXEC_STATUS="$?"
if [ "$EXEC_STATUS" -ne 0 ]; then
  exit "$EXEC_STATUS"
fi

echo "ThreadedFFIMigration enableThreadedFFI. Smalltalk snapshot: true andQuit: true."  > tffi.st
echo "GtWorld openDefault. 5 seconds wait. BlHost pickHost universe snapshot: true andQuit: true." > gtworld.st

./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkit.image st tffi.st

EXEC_STATUS="$?"
if [ "$EXEC_STATUS" -ne 0 ]; then
  exit "$EXEC_STATUS"
fi

./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkit.image st gtworld.st --interactive --no-quit

EXEC_STATUS="$?"
if [ "$EXEC_STATUS" -ne 0 ]; then
  exit "$EXEC_STATUS"
fi

echo "Setup process complete. To start GlamorousToolkit run \n ./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkit.image --no-quit --interactive"

exit 0
