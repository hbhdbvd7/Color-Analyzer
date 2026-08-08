param(
    [Parameter(Mandatory = $true)]
    [string]$PortableZip,
    [string]$OutputPath,
    [string]$IExpressPath
)

$ErrorActionPreference = 'Stop'

if (-not $OutputPath) { $OutputPath = Join-Path $PSScriptRoot 'Color-Analyzer-0.1.0-Setup.exe' }
if (-not $IExpressPath) { $IExpressPath = Join-Path $env:SystemRoot 'System32\iexpress.exe' }

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$portableZipPath = (Resolve-Path $PortableZip).Path
$iexpress = (Resolve-Path $IExpressPath).Path
$output = [System.IO.Path]::GetFullPath($OutputPath)
$outputDir = Split-Path -Parent $output

if (-not (Test-Path -LiteralPath $portableZipPath -PathType Leaf)) {
    throw "Portable ZIP was not found: $PortableZip"
}
if (-not (Test-Path -LiteralPath $iexpress -PathType Leaf)) {
    throw "IExpress was not found: $IExpressPath"
}

New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
$staging = Join-Path $env:TEMP ('ColorAnalyzer-IExpress-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $staging -Force | Out-Null

Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'install.cmd') -Destination $staging -Force
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'install.ps1') -Destination $staging -Force
Copy-Item -LiteralPath $portableZipPath -Destination (Join-Path $staging 'Color-Analyzer-0.1.0-windows-x64-CPU-portable.zip') -Force

$sedPath = Join-Path $staging 'Color-Analyzer.sed'
$sed = @"
[Version]
Class=IEXPRESS
SEDVersion=3
[Options]
PackagePurpose=InstallApp
ShowInstallProgramWindow=0
HideExtractAnimation=1
UseLongFileName=1
InsideCompressed=1
CAB_FixedSize=0
CAB_ResvCodeSigning=0
RebootMode=N
InstallPrompt=%InstallPrompt%
DisplayLicense=%DisplayLicense%
FinishMessage=%FinishMessage%
TargetName=%TargetName%
FriendlyName=%FriendlyName%
AppLaunched=%AppLaunched%
PostInstallCmd=%PostInstallCmd%
AdminQuietInstCmd=%AdminQuietInstCmd%
UserQuietInstCmd=%UserQuietInstCmd%
SourceFiles=SourceFiles
[Strings]
InstallPrompt=
DisplayLicense=
FinishMessage=
TargetName=$output
FriendlyName=Color Analyzer 0.1.0 CPU Setup
AppLaunched=install.cmd
PostInstallCmd=<None>
AdminQuietInstCmd=install.cmd
UserQuietInstCmd=install.cmd
FILE0="install.cmd"
FILE1="install.ps1"
FILE2="Color-Analyzer-0.1.0-windows-x64-CPU-portable.zip"
[SourceFiles]
SourceFiles0=$staging\
[SourceFiles0]
%FILE0%=
%FILE1%=
%FILE2%=
"@
Set-Content -LiteralPath $sedPath -Value $sed -Encoding ASCII

$process = Start-Process -FilePath $iexpress -ArgumentList @('/N', '/Q', $sedPath) -Wait -PassThru
if (-not (Test-Path -LiteralPath $output -PathType Leaf)) {
    throw "IExpress failed with exit code $($process.ExitCode); installer was not created: $output"
}

$hash = Get-FileHash -LiteralPath $output -Algorithm SHA256
Write-Output "Installer: $output"
Write-Output "Size: $((Get-Item -LiteralPath $output).Length) bytes"
Write-Output "SHA-256: $($hash.Hash)"
