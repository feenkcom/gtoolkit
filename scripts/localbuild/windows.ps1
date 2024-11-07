$installer = "gt-installer"
$osArchitecture = [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture
$installerArch = switch ($osArchitecture) {
    "X64"  { "x86_64" }
    "Arm64" { "aarch64" }
    Default { throw "Your architecture is currently unsupported" }
}

curl -o "$installer.exe" "https://github.com/feenkcom/gtoolkit-maestro-rs/releases/latest/download/$installer-$installerArch-pc-windows-msvc.exe"
$cmd = ".\$installer.exe local-build"
Invoke-Expression $cmd
