
git clean -fdx
Get-ChildItem . | Where {$_.PSIsContainer -and ($_ -match '^GlamorousToolkitWin64-')} | Remove-Item -Recurse -Force

wget https://dl.feenk.com/tentative/GlamorousToolkitWin64.zip -OutFile GlamorousToolkitWin64.zip
Expand-Archive GlamorousToolkitWin64.zip -DestinationPath .