#requires -Version 2

$image=Get-Childitem -Include *.image -Recurse -Name
$gtfolder=Get-Childitem -Include GlamorousToolkitWin64-* -Name

echo $image


Rename-Item $gtfolder .\GlamorousToolkitWin


$maximumRuntimeSeconds = 1200

$process = Start-Process -FilePath .\GlamorousToolkitWin\GlamorousToolkitConsole.exe -ArgumentList ' .\GlamorousToolkitWin\GlamorousToolkit.image dedicatedReleaseBranchExamples --junit-xml-output' -PassThru

try
{
    $process | Wait-Process -Timeout $maximumRuntimeSeconds -ErrorAction Stop
    Write-Warning -Message 'Process successfully completed within timeout.'
}
catch
{
    Write-Warning -Message 'Process exceeded timeout, will be killed now.'
    $process | Stop-Process -Force
}


$maximumRuntimeSeconds = 1200

$process = Start-Process -FilePath .\GlamorousToolkitWin\GlamorousToolkitConsole.exe -ArgumentList ' .\GlamorousToolkitWin\GlamorousToolkit.image dedicatedReleaseBranchSlides --junit-xml-output' -PassThru

try
{
    $process | Wait-Process -Timeout $maximumRuntimeSeconds -ErrorAction Stop
    Write-Warning -Message 'Process successfully completed within timeout.'
}
catch
{
    Write-Warning -Message 'Process exceeded timeout, will be killed now.'
    $process | Stop-Process -Force
}


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
