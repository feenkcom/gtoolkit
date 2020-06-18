
git clean -fdx
echo $env:UserName 
net user

wget https://dl.feenk.com/tentative/GlamorousToolkitWin64.zip -OutFile GlamorousToolkitWin64.zip
Expand-Archive GlamorousToolkitWin64.zip -DestinationPath .



$acl = Get-Acl GlamorousToolkitWin64-*

$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("EC2AMAZ-NPR6PPU\DefaultUser","FullControl","Allow")

$acl.SetAccessRule($AccessRule)

$acl | Set-Acl GlamorousToolkitWin64-*