Import-Module BitsTransfer

$url = "https://github.com/feenkcom/opensmalltalk-vm/releases/latest/download/build-artifacts.zip"
$output = "build-artifacts.zip"
Start-BitsTransfer -Source $url -Destination $output

$url = "https://raw.githubusercontent.com/feenkcom/gtoolkit/master/scripts/localbuild/loadgt.st"
$output = "loadgt.st"
Start-BitsTransfer -Source $url -Destination $output


$url = "https://files.pharo.org/get-files/80/pharo64.zip"
$output = "pharo64.zip"
Start-BitsTransfer -Source $url -Destination $output

Expand-Archive build-artifacts.zip -DestinationPath .
Expand-Archive build-artifacts\GlamorousToolkitVM-*-win64-bin.zip  -DestinationPath GlamorousToolkit
Expand-Archive pharo64.zip -DestinationPath GlamorousToolkit 
Move-Item .\GlamorousToolkit\Pharo8.0-SNAPSHOT-64bit-*.image .\GlamorousToolkit\Pharo.image
Move-Item .\GlamorousToolkit\Pharo8.0-SNAPSHOT-64bit-*.changes .\GlamorousToolkit\Pharo.changes
.\GlamorousToolkit\GlamorousToolkitConsole.exe .\GlamorousToolkit\Pharo.image st --quit .\loadgt.st
.\GlamorousToolkit\GlamorousToolkitConsole.exe .\GlamorousToolkit\Pharo.image eval --save "ThreadedFFIMigration enableThreadedFFI." 
.\GlamorousToolkit\GlamorousToolkitConsole.exe .\GlamorousToolkit\Pharo.image eval --interactive --no-quit 'GtWorld openWithShutdownListener. 30 seconds wait. BlHost pickHost universe snapshot: true andQuit: true.'
.\GlamorousToolkit\GlamorousToolkitConsole.exe .\GlamorousToolkit\Pharo.image --interactive --no-quit