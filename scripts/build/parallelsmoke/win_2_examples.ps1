$image=Get-Childitem -Include *.image -Recurse -Name
echo $image

$timeoutSeconds = 10
$code = {
    .\GlamorousToolkitWin64-*\GlamorousToolkitConsole.exe $image eval "1+2" > out.txt
}
$j = Start-Job -ScriptBlock $code
if (Wait-Job $j -Timeout $timeoutSeconds) { Receive-Job $j }
Remove-Job -force $j

cat out.txt
# .\GlamorousToolkitWin64-*\GlamorousToolkitConsole.exe $image examples --junit-xml-output 'GToolkit-.*' 'GT4SmaCC-.*' 'DeepTraverser-.*' 'Brick' 'Brick-.*' 'Bloc-*' 'Bloc' 
rm .\GToolkit-Releaser-*
rm .\GToolkit-Documenter-XDoc-Examples.xml
