$image=Get-Childitem -Include *.image -Recurse -Name

echo $image

.\GlamorousToolkitWin64-*\GlamorousToolkitConsole.exe $image dedicatedReleaseBranchExamples --junit-xml-output
.\GlamorousToolkitWin64-*\GlamorousToolkitConsole.exe $image dedicatedReleaseBranchSlides --junit-xml-output

$FileName = ".\GToolkit-Documenter-XDoc-Examples.xml"
if (Test-Path $FileName) 
{
  Remove-Item $FileName
}

$FileName = ".\PharoLink-Examples.xml"
if (Test-Path $FileName) 
{
  Remove-Item $FileName
}