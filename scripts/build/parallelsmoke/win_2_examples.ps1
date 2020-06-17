$image=Get-Childitem -Include *.image -Recurse -Name
echo $image
.\GlamorousToolkitWin64-*\GlamorousToolkitConsole.exe $image eval "1+2" > out.txt
cat out.txt
# .\GlamorousToolkitWin64-*\GlamorousToolkitConsole.exe $image examples --junit-xml-output 'GToolkit-.*' 'GT4SmaCC-.*' 'DeepTraverser-.*' 'Brick' 'Brick-.*' 'Bloc-*' 'Bloc' 
rm .\GToolkit-Releaser-*
rm .\GToolkit-Documenter-XDoc-Examples.xml
