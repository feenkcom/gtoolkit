$image=Get-Childitem -Include *.image -Recurse -Name

(get-acl $image).access | ft IdentityReference,FileSystemRights,AccessControlType,IsInherited,InheritanceFlags -auto 

$fullPathImage = (Join-Path (pwd) $image)
echo $fullPathImage

$timeoutSeconds = 10
$code = {
    .\GlamorousToolkitWin64-*\GlamorousToolkitConsole.exe "$fullPathImage" eval "1+2"
}
$j = Start-Job -ScriptBlock $code
if (Wait-Job $j -Timeout $timeoutSeconds) { Receive-Job $j }
Remove-Job -force $j

# .\GlamorousToolkitWin64-*\GlamorousToolkitConsole.exe $image examples --junit-xml-output 'GToolkit-.*' 'GT4SmaCC-.*' 'DeepTraverser-.*' 'Brick' 'Brick-.*' 'Bloc-*' 'Bloc' 
# rm .\GToolkit-Releaser-*
# rm .\GToolkit-Documenter-XDoc-Examples.xml
