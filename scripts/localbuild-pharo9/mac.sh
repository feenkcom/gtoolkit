#!/bin/sh

DIR="glamoroustoolkit"
REMOTE_SCRIPTS_DIR="https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild-pharo9"
GTOOLKIT_APP_URL="https://github.com/feenkcom/gtoolkit-vm/releases/latest/download"
PHARO_VM_DIR="pharo9-vm"
PHARO_VM_EXECUTABLE="./pharo9-vm/pharo"
GTOOLKIT_APP_EXECUTABLE="./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit-cli"

LOAD_PATCHES_SCRIPT="load-patches.st"
LOAD_TASKIT_SCRIPT="load-taskit.st"
LOAD_GT_SCRIPT="load-gt.st"

if [ -d "$DIR" ]; then
  echo "The folder $DIR is present in the current directory, perhaps it is already installed?"
  exit 1
fi

mkdir $DIR
cd $DIR || exit

LOAD_PATCHES="../$LOAD_PATCHES_SCRIPT"
if [ ! -f "$LOAD_PATCHES" ]; then
    LOAD_PATCHES="./$LOAD_PATCHES_SCRIPT"
    if [ ! -f "$LOAD_PATCHES" ]; then
      curl -L "$REMOTE_SCRIPTS_DIR/$LOAD_PATCHES_SCRIPT" -o "$LOAD_PATCHES_SCRIPT"
    fi
fi

LOAD_TASKIT="../$LOAD_TASKIT_SCRIPT"
if [ ! -f "$LOAD_TASKIT" ]; then
    LOAD_TASKIT="./$LOAD_TASKIT_SCRIPT"
    if [ ! -f "$LOAD_TASKIT" ]; then
      curl -L "$REMOTE_SCRIPTS_DIR/$LOAD_TASKIT_SCRIPT" -o "$LOAD_TASKIT_SCRIPT"
    fi
fi

LOAD_GT="../$LOAD_GT_SCRIPT"
if [ ! -f "$LOAD_GT" ]; then
    LOAD_GT="./$LOAD_GT_SCRIPT"
    if [ ! -f "$LOAD_GT" ]; then
      curl -L "$REMOTE_SCRIPTS_DIR/$LOAD_GT_SCRIPT" -o "$LOAD_GT_SCRIPT"
    fi
fi

arch_name="$(uname -m)"
if [ "${arch_name}" = "x86_64" ]; then
    if [ "$(sysctl -in sysctl.proc_translated)" = "1" ]; then
        is_m1=true
    else
        is_m1=false
    fi
elif [ "${arch_name}" = "arm64" ]; then
    is_m1=true
else
    is_m1=false
fi

if [ "$is_m1" = true ] ; then
  curl -L "$GTOOLKIT_APP_URL/GlamorousToolkit-aarch64-apple-darwin.app.zip" -o GlamorousToolkit.app.zip
else
  curl -L "$GTOOLKIT_APP_URL/GlamorousToolkit-x86_64-apple-darwin.app.zip" -o GlamorousToolkit.app.zip
fi

unzip GlamorousToolkit.app.zip

curl https://get.pharo.org/64/90  | bash
mv Pharo.image GlamorousToolkit.image
mv Pharo.changes GlamorousToolkit.changes

mkdir $PHARO_VM_DIR
cd $PHARO_VM_DIR || exit
curl https://get.pharo.org/64/vm90 | bash
cd .. || exit

time $PHARO_VM_EXECUTABLE GlamorousToolkit.image st --quit "$LOAD_PATCHES" 2>&1 || exit
time $PHARO_VM_EXECUTABLE GlamorousToolkit.image st --quit "$LOAD_TASKIT" 2>&1 || exit

if [ $# -eq 1 ] && [ "$1" = "https" ]
then
  echo "Iceberg remoteTypeSelector: #httpsUrl. Smalltalk snapshot: true andQuit: true."  > icehttps.st
  $PHARO_VM_EXECUTABLE GlamorousToolkit.image st icehttps.st
fi

time $GTOOLKIT_APP_EXECUTABLE GlamorousToolkit.image st --quit "$LOAD_GT" 2>&1 || exit

EXEC_STATUS="$?"
if [ "$EXEC_STATUS" -ne 0 ]; then
  exit "$EXEC_STATUS"
fi

echo "GtWorld openDefault. 5 seconds wait. BlHost pickHost universe snapshot: true andQuit: true." > gtworld.st

EXEC_STATUS="$?"
if [ "$EXEC_STATUS" -ne 0 ]; then
  exit "$EXEC_STATUS"
fi

time $GTOOLKIT_APP_EXECUTABLE GlamorousToolkit.image st gtworld.st --no-quit

EXEC_STATUS="$?"
if [ "$EXEC_STATUS" -ne 0 ]; then
  exit "$EXEC_STATUS"
fi

printf "Setup process complete. To start GlamorousToolkit run \n./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit\n"
exit 0
