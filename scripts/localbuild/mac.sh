#/bin/sh!
set -o xtrace

mv pharo-local ../

find . ! -name '*.st' ! -name '*.sh' ! -name '.' -exec rm -rf {} +

mv  ../pharo-local .

curl https://get.pharo.org/64/80 | bash

curl https://dl.feenk.com/gtvm/Pharo-8.2.0-654ac0031-mac64-bin.zip -o Pharo-8.2.0-654ac0031-mac64-bin.zip
unzip Pharo-8.2.0-654ac0031-mac64-bin.zip

time ./Pharo.app/Contents/MacOS/pharo Pharo.image st --quit loadgt.st 2>&1

#./Pharo.app/Contents/MacOS/pharo Pharo.image eval "GtWorld openWithShutdownListener. 60 seconds wait. BlHost pickHost universe snapshot: true andQuit: true"

exit 0