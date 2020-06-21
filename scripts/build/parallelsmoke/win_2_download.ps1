
#wget https://dl.feenk.com/tentative/GlamorousToolkitWin64.zip -OutFile GlamorousToolkitWin64.zip

$url = "https://dl.feenk.com/tentative/GlamorousToolkitWin64.zip"
$output = "GlamorousToolkitWin64.zip"
$start_time = Get-Date

Import-Module BitsTransfer
Start-BitsTransfer -Source $url -Destination $output

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"