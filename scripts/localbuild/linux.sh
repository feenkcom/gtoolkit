
set -o xtrace
#find . ! -name '*.st' ! -name '*.sh' ! -name '.' -exec rm -rf {} +

wget https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/loadgt.st -O loadgt.st

curl https://get.pharo.org/64/80 | bash

wget https://github.com/feenkcom/opensmalltalk-vm/releases/latest/download/build-artifacts.zip -O build-artifacts.zip
unzip build-artifacts.zip
unzip build-artifacts/GToolkitVM-8.2.0-*-linux64-bin.zip

time ./gtoolkit Pharo.image st --quit loadgt.st 2>&1
./gtoolkit Pharo.image examples --junit-xml-output  'GToolkit-Coder-Examples' 'GToolkit-.*' 'GT4SmaCC-.*' 'DeepTraverser-.*' 'Brick' 'Brick-.*' 'Bloc' 'Bloc-.*' 'Sparta-.*' 2>&1
./gtoolkit Pharo.image eval --save "ThreadedFFIMigration enableThreadedFFI." 
# ./GToolkit.app/Contents/MacOS/GToolkit Pharo.image eval --interactive --no-quit "GtWorld openWithShutdownListener. 30 seconds wait. BlHost pickHost universe snapshot: true andQuit: true."
./gtoolkit Pharo.image examples --junit-xml-output  'GToolkit-Coder-Examples' 'GToolkit-.*' 'GT4SmaCC-.*' 'DeepTraverser-.*' 'Brick' 'Brick-.*' 'Bloc' 'Bloc-.*' 'Sparta-.*' 2>&1