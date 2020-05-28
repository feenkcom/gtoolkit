$image=Get-Childitem -Include *.image -Recurse -Name
.\GlamorousToolkitWin64-*\GlamorousToolkitConsole.exe $image examples --junit-xml-output 'GToolkit-.*' 'GT4SmaCC-.*' 'DeepTraverser-.*' 'Brick' 'Brick-.*' 'Bloc-*' 'Bloc' 
rm .\GToolkit-Releaser-*
rm .\GToolkit-Documenter-XDoc-Examples.xml
