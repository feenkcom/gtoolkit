
wget https://github.com/feenkcom/opensmalltalk-vm/releases/latest/download/build-artifacts.zip -OutFile build-artifacts.zip
Expand-Archive build-artifacts.zip -DestinationPath .
Expand-Archive build-artifacts\GToolkitVM-8.2.0-*-win64-bin.zip  -DestinationPath GToolkit
wget https://files.pharo.org/get-files/80/pharo64.zip -OutFile pharo64.zip
Expand-Archive pharo64.zip -DestinationPath GToolkit 
mv .\GToolkit\Pharo8.0-SNAPSHOT-64bit-*.image .\GToolkit\Pharo.image
mv .\GToolkit\Pharo8.0-SNAPSHOT-64bit-*.changes .\GToolkit\Pharo.changes
.\GToolkit\GToolkitConsole.exe .\GToolkit\Pharo.image st --quit .\loadgt.st
.\GToolkit\GToolkitConsole.exe .\GToolkit\Pharo.image eval --save "ThreadedFFIMigration enableThreadedFFI." 
.\GToolkit\GToolkitConsole.exe .\GToolkit\Pharo.image eval --interactive --no-quit 'GtWorld openWithShutdownListener. 30 seconds wait. BlHost pickHost universe snapshot: true andQuit: true.'
.\GToolkit\GToolkitConsole.exe .\GToolkit\Pharo.image --interactive --no-quit