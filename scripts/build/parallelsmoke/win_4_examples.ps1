$image=Get-Childitem -Include *.image -Recurse -Name

echo $image

.\GlamorousToolkitWin64-*\GlamorousToolkitConsole.exe $image dedicatedReleaseBranchExamples --junit-xml-output
# .\GlamorousToolkitWin64-*\GlamorousToolkitConsole.exe $image slides --junit-xml-output $EXAMPLE_PACKAGES

# rm .\GToolkit-Releaser-*
rm .\GToolkit-Documenter-XDoc-Examples.xml
