$image=Get-Childitem -Include *.image -Recurse -Name
.\GlamorousToolkitWin64\GlamorousToolkitConsole.exe $image examples --junit-xml-output 'Brick' 'Brick-.*' 'Bloc' 'Bloc-*'
