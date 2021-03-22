#requires -Version 2

$maximumRuntimeSeconds = 1200

$process = Start-Process -FilePath .\GlamorousToolkitWin\GlamorousToolkitConsole.exe -ArgumentList ' .\GlamorousToolkitWin\GlamorousToolkit.image dedicatedReleaseBranchExamples --junit-xml-output --verbose' -PassThru

try
{
    $process | Wait-Process -Timeout $maximumRuntimeSeconds -ErrorAction Stop
    Write-Warning -Message 'Process successfully completed within timeout.'
}
catch
{
    Write-Warning -Message 'Process exceeded timeout, will be killed now.'
    $process | Stop-Process -Force
    exit 1
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
    exit 1
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
