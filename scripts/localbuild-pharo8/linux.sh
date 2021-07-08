#/bin/sh!
#
# Install Glamorous Toolkit
#
# By default Gt is installed in to a subdirectory named glamoroustoolkit.
# Defining GT_INSTALL_HERE=1 tells the install to be in the current 
# directory, which must be empty.
#
DIR=glamoroustoolkit
# find . ! -name '*.st' ! -name '*.sh' ! -name '.' -exec rm -rf {} +

if [ ${GT_INSTALL_HERE}0 -ne 10 ]; then
  if [ -d "$DIR" ]; then
    echo "The folder $DIR is present in the current directory, perhaps it is already installed?"
    exit 1
  fi
  mkdir $DIR
  cd $DIR
else
  if [ -n "$(ls -A)" ]; then
      echo "Current directory isn't empty"
      exit 1
  fi
fi

set -e
set -o xtrace

curl -L https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/loadgt.st -o loadgt.st
curl -L https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/loadice.st -o loadice.st

curl https://get.pharo.org/64/80 | bash

mv Pharo.image GlamorousToolkit.image
mv Pharo.changes GlamorousToolkit.changes

curl -L https://github.com/feenkcom/opensmalltalk-vm/releases/latest/download/build-artifacts.zip -o build-artifacts.zip
unzip build-artifacts.zip
unzip build-artifacts/GlamorousToolkitVM-*-linux64-bin.zip

if [ $# -eq 1 ] && [ $1 == "https" ]
then
  echo "Iceberg remoteTypeSelector: #httpsUrl. Smalltalk snapshot: true andQuit: true."  > icehttps.st
  ./glamoroustoolkit GlamorousToolkit.image st icehttps.st
fi

time ./glamoroustoolkit GlamorousToolkit.image st --quit loadice.st 2>&1
time ./glamoroustoolkit GlamorousToolkit.image st --quit loadgt.st 2>&1

echo "ThreadedFFIMigration enableThreadedFFI. Smalltalk snapshot: true andQuit: true."  > tffi.st
echo "GtWorld openDefault. 5 seconds wait. BlHost pickHost universe snapshot: true andQuit: true." > gtworld.st
./glamoroustoolkit GlamorousToolkit.image st tffi.st
./glamoroustoolkit GlamorousToolkit.image st gtworld.st --interactive --no-quit 
echo "Setup process complete. To start GlamorousToolkit run \n ./glamoroustoolkit GlamorousToolkit.image --no-quit --interactive"

cd ..

exit 0
