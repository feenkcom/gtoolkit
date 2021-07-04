#!/bin/sh

DIR="glamoroustoolkit"
REMOTE_SCRIPTS_DIR="https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild2"
GTOOLKIT_APP_URL="https://github.com/feenkcom/gtoolkit-vm/releases/latest/download"
PHARO_VM_DIR="pharo8-vm"
PHARO_VM_EXECUTABLE="./pharo8-vm/pharo"
GTOOLKIT_APP_EXECUTABLE="./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit-cli"

LOAD_ICEBERG_SCRIPT="load-iceberg.st"
LOAD_FFI_BACKPORT_SCRIPT="load-ffi-backport.st"
LOAD_TFFI_MIGRATION_SCRIPT="load-tffi-migration.st"
LOAD_GT_SCRIPT="loadgt.st"

if [ -d "$DIR" ]; then
  echo "The folder $DIR is present in the current directory, perhaps it is already installed?"
  exit 1
fi

mkdir $DIR
cd $DIR || exit

LOAD_ICEBERG="../$LOAD_ICEBERG_SCRIPT"
if [ ! -f "$LOAD_ICEBERG" ]; then
    LOAD_ICEBERG="./$LOAD_ICEBERG_SCRIPT"
    if [ ! -f "$LOAD_ICEBERG" ]; then
      curl -L "$REMOTE_SCRIPTS_DIR/$LOAD_ICEBERG_SCRIPT" -o "$LOAD_ICEBERG_SCRIPT"
    fi
fi

LOAD_FFI_BACKPORT="../$LOAD_FFI_BACKPORT_SCRIPT"
if [ ! -f "$LOAD_FFI_BACKPORT" ]; then
    LOAD_FFI_BACKPORT="./$LOAD_FFI_BACKPORT_SCRIPT"
    if [ ! -f "$LOAD_FFI_BACKPORT" ]; then
      curl -L "$REMOTE_SCRIPTS_DIR/$LOAD_FFI_BACKPORT_SCRIPT" -o "$LOAD_FFI_BACKPORT_SCRIPT"
    fi
fi

LOAD_TFFI_MIGRATION="../$LOAD_TFFI_MIGRATION_SCRIPT"
if [ ! -f "$LOAD_TFFI_MIGRATION" ]; then
    LOAD_TFFI_MIGRATION="./$LOAD_TFFI_MIGRATION_SCRIPT"
    if [ ! -f "$LOAD_TFFI_MIGRATION" ]; then
      curl -L "$REMOTE_SCRIPTS_DIR/$LOAD_TFFI_MIGRATION_SCRIPT" -o "$LOAD_TFFI_MIGRATION_SCRIPT"
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

curl https://get.pharo.org/64/80  | bash
mv Pharo.image GlamorousToolkit.image
mv Pharo.changes GlamorousToolkit.changes

mkdir $PHARO_VM_DIR
cd $PHARO_VM_DIR || exit
curl https://get.pharo.org/64/vm80 | bash
cd .. || exit

if [ $# -eq 1 ] && [ "$1" = "https" ]
then
  echo "Iceberg remoteTypeSelector: #httpsUrl. Smalltalk snapshot: true andQuit: true."  > icehttps.st
  $PHARO_VM_EXECUTABLE GlamorousToolkit.image st icehttps.st
fi

time $PHARO_VM_EXECUTABLE GlamorousToolkit.image st --quit "$LOAD_ICEBERG" 2>&1
time $PHARO_VM_EXECUTABLE GlamorousToolkit.image st --quit "$LOAD_GT" 2>&1

time $PHARO_VM_EXECUTABLE GlamorousToolkit.image st --quit "$LOAD_FFI_BACKPORT" 2>&1
time $PHARO_VM_EXECUTABLE GlamorousToolkit.image st --quit "$LOAD_TFFI_MIGRATION" 2>&1

#time $GTOOLKIT_APP_EXECUTABLE GlamorousToolkit.image st --quit "../load-sparta.st" 2>&1

EXEC_STATUS="$?"
if [ "$EXEC_STATUS" -ne 0 ]; then
  exit "$EXEC_STATUS"
fi
#
#echo "ThreadedFFIMigration enableThreadedFFI. Smalltalk snapshot: true andQuit: true."  > load-tffi-migration.st
#echo "GtWorld openDefault. 5 seconds wait. BlHost pickHost universe snapshot: true andQuit: true." > gtworld.st
#
#./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkit.image st load-tffi-migration.st
#
#EXEC_STATUS="$?"
#if [ "$EXEC_STATUS" -ne 0 ]; then
#  exit "$EXEC_STATUS"
#fi
#
#./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkit.image st gtworld.st --interactive --no-quit
#
#EXEC_STATUS="$?"
#if [ "$EXEC_STATUS" -ne 0 ]; then
#  exit "$EXEC_STATUS"
#fi

echo "Setup process complete. To start GlamorousToolkit run \n ./GlamorousToolkit.app/Contents/MacOS/GlamorousToolkit GlamorousToolkit.image --no-quit --interactive"
cd ..
exit 0
