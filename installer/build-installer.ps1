param(
    [string]$OutputPath,
    [string]$IsccPath
)

$ErrorActionPreference = 'Stop'

if (-not $OutputPath) {
    $OutputPath = Join-Path $PSScriptRoot 'Color-Analyzer-0.1.0-CPU-Installer.zip'
}

if (-not $IsccPath) {
    $candidates = @(
        (Join-Path $env:LOCALAPPDATA 'Programs\Inno Setup 6\ISCC.exe'),
        'C:\Program Files\Inno Setup 7\ISCC.exe',
        'C:\Program Files (x86)\Inno Setup 7\ISCC.exe',
        'C:\Program Files (x86)\Inno Setup 6\ISCC.exe'
    )
    $IsccPath = $candidates | Where-Object { Test-Path -LiteralPath $_ -PathType Leaf } | Select-Object -First 1
}

if (-not $IsccPath -or -not (Test-Path -LiteralPath $IsccPath -PathType Leaf)) {
    throw 'Inno Setup ISCC.exe was not found. Install Inno Setup 6 or 7, or pass -IsccPath explicitly.'
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$issPath = Join-Path $PSScriptRoot 'Color-Analyzer.iss'
$outputZip = [System.IO.Path]::GetFullPath($OutputPath)
$outputDir = Split-Path -Parent $outputZip
$buildDir = Join-Path $env:TEMP ('ColorAnalyzer-Inno-' + [guid]::NewGuid().ToString('N'))
$packageRoot = Join-Path $buildDir 'Color Analyzer 0.1.0 CPU Installer'

New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
New-Item -ItemType Directory -Path $buildDir -Force | Out-Null
New-Item -ItemType Directory -Path $packageRoot -Force | Out-Null

& $IsccPath '/Q' ("/DOutputDir=$buildDir") $issPath
if ($LASTEXITCODE -ne 0) {
    throw "Inno Setup compilation failed with exit code $LASTEXITCODE"
}

$setupExe = Join-Path $buildDir 'Color-Analyzer-0.1.0-Setup.exe'
if (-not (Test-Path -LiteralPath $setupExe -PathType Leaf)) {
    throw "Inno Setup did not create the installer: $setupExe"
}

Copy-Item -LiteralPath $setupExe -Destination $packageRoot -Force
Copy-Item -LiteralPath (Join-Path $repoRoot 'INSTALLER.md') -Destination $packageRoot -Force
Compress-Archive -Path $packageRoot -DestinationPath $outputZip -CompressionLevel Optimal -Force

$hash = Get-FileHash -LiteralPath $outputZip -Algorithm SHA256
Write-Output "Installer ZIP: $outputZip"
Write-Output "Setup EXE size: $((Get-Item -LiteralPath $setupExe).Length) bytes"
Write-Output "ZIP size: $((Get-Item -LiteralPath $outputZip).Length) bytes"
Write-Output "ZIP SHA-256: $($hash.Hash)"
