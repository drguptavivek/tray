# Run from the extracted VCMS zip (needs Administrator for the default Program Files destination).
# Mirrors the official installer's steps (preinstall, install, certgen) using the bundled signed runtime and the VCMS jar.
param([string]$Dest = 'C:\Program Files\QZ Tray')
$ErrorActionPreference = 'Stop'
$here = $PSScriptRoot
$java = Join-Path $here 'runtime\bin\java.exe'
$jar = Join-Path $here 'qz-tray.jar'
foreach ($step in @(@('preinstall'), @('install', '--dest', $Dest), @('certgen'))) {
    & $java -Djna.nosys=true -jar $jar @step
    if ($LASTEXITCODE -ne 0) { throw "Step '$($step[0])' failed ($LASTEXITCODE)" }
}
Start-Process (Join-Path $Dest 'qz-tray.exe')
Write-Host "Installed to $Dest"
