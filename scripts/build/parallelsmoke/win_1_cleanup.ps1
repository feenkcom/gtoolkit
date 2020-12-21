git clean -fdx
Get-ChildItem . | Where {$_.PSIsContainer -and ($_ -match '^GlamorousToolkitWin')} | Remove-Item -Recurse -Force
pwd 
ls

