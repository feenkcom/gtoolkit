git clean -fdx
Get-ChildItem . | Where {$_.PSIsContainer -and ($_ -match '^GlamorousToolkitWin64-')} | Remove-Item -Recurse -Force
pwd 
ls

