$installer = "gt-installer"
curl -o "$installer.exe" "https://github.com/feenkcom/gtoolkit-maestro-rs/releases/latest/download/$installer-x86_64-pc-windows-msvc.exe"
$cmd = ".\$installer.exe local-build"
Invoke-Expression $cmd
