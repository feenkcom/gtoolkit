Expand-Archive GlamorousToolkitWin64.zip -DestinationPath .
$gtfolder=Get-Childitem -Include GlamorousToolkitWin64-* -Name


Rename-Item $gtfolder .\GlamorousToolkitWin
