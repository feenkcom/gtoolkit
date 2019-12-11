#/bin/sh!
set -o xtrace

find . ! -name '*.st' ! -name '*.sh' ! -name '.' -exec rm -rf {} +

GTVERSION=$(curl -s https://api.github.com/repos/feenkcom/gtoolkit/releases/latest | grep tag_name | cut -d '"' -f 4)
TIMESTAMP=$(curl -s https://api.github.com/repos/feenkcom/gtoolkit/releases/latest | grep /GToolkit | cut -d '"' -f 4 | tail -c 19 | cut -c1-14)

curl https://get.pharo.org/64/vm80 | bash

wget https://github.com/feenkcom/gtoolkit/releases/download/$GTVERSION/GToolkit-64-$GTVERSION-$TIMESTAMP.zip -O image.zip 
unzip -o image.zip 
mv GToolkit-64-$GTVERSION-$TIMESTAMP/GToolkit-64-$GTVERSION-"$TIMESTAMP"64.image Pharo.image
mv GToolkit-64-$GTVERSION-$TIMESTAMP/GToolkit-64-$GTVERSION-"$TIMESTAMP"64.changes Pharo.changes
mv GToolkit-64-$GTVERSION-$TIMESTAMP/Pharo8*.sources .
mv GToolkit-64-$GTVERSION-$TIMESTAMP/gt-extra gt-extra
wget https://github.com/feenkcom/gtoolkit/releases/download/$GTVERSION/libLinux64-$GTVERSION.zip -O libLinux64-$GTVERSION.zip
unzip -o libLinux64-$GTVERSION.zip
mv libLinux64-$GTVERSION/lib* .

./pharo Pharo.image st --quit loadsociator.st 2>&1

./pharo Pharo.image sociator-es-load

curl https://dl.feenk.com/gtvm/Pharo-8.2.0-654ac0031-linux64-bin.zip -o Pharo-8.2.0-654ac0031-linux64-bin.zip
unzip Pharo-8.2.0-654ac0031-linux64-bin.zip -d headless

./headless/pharo Pharo.image eval --interactive --no-quit "SoEsAppModel openDefaultWithShutdownHandler. 60 seconds wait. BlHost pickHost universe snapshot: true andQuit: true"



exit 0