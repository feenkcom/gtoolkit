$image=Get-Childitem -Include *.image -Recurse -Name
.\GToolkitWin64\GToolkitConsole.exe $image examples --junit-xml-output 'GToolkit-Coder-Examples'
