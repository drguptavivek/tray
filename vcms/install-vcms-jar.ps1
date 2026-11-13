# Swap the VCMS-built qz-tray.jar into an installed, upstream-signed QZ Tray (same version, e.g. 2.3.0).
# Run as Administrator: .\install-vcms-jar.ps1 -Jar .\qz-tray.jar
param([Parameter(Mandatory)][string]$Jar, [string]$Dir = 'C:\Program Files\QZ Tray')
$ErrorActionPreference = 'Stop'
if (-not (Test-Path "$Dir\qz-tray.exe")) { throw "Upstream QZ Tray not found in $Dir. Install the official signed installer first." }
$sig = Get-AuthenticodeSignature "$Dir\qz-tray.exe"
if ($sig.Status -ne 'Valid') { throw "qz-tray.exe signature is $($sig.Status); install the official signed upstream build." }
Get-Process -Name 'qz-tray*', 'javaw' -ErrorAction SilentlyContinue | Where-Object { $_.Path -like "$Dir*" } | Stop-Process -Force
if (-not (Test-Path "$Dir\qz-tray.jar.orig")) { Copy-Item "$Dir\qz-tray.jar" "$Dir\qz-tray.jar.orig" }
Copy-Item $Jar "$Dir\qz-tray.jar" -Force
Start-Process "$Dir\qz-tray.exe"
Write-Host "Installed VCMS jar. Original kept as qz-tray.jar.orig"
