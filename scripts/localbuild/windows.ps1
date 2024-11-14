$installer = "gt-maestro"
$osArchitecture = (Get-CimInstance -ClassName Win32_OperatingSystem).OSArchitecture

if ($osArchitecture -match "64") {
	if ($osArchitecture -match "ARM") {
		$installerArch = "aarch64"
	}
	else {
		$installerArch = "x86_64"
	}
}
else {
	throw "Your architecture ($osArchitecture) is currently unsupported"
}


curl -o "$installer.exe" "https://github.com/feenkcom/gtoolkit-maestro-rs/releases/latest/download/gt-installer-$installerArch-pc-windows-msvc.exe"
Start-Process -FilePath ".\$installer.exe" -ArgumentList "local-build" -Wait -NoNewWindow
