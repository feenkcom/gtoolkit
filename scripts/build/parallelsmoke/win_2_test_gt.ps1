$image=Get-Childitem -Include *.image -Recurse -Name
.\GToolkitWin64\GToolkitConsole.exe $image examples --junit-xml-output 'GToolkit-.*' 'GT4SmaCC-.*' 'DeepTraverser-.*'
rm .\GToolkit-Releaser-*
rm .\GToolkit-Documenter-XDoc-Examples.xml
