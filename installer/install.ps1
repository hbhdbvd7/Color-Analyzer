param(
    [Parameter(Mandatory = $true)]
    [string]$ZipPath
)

$ErrorActionPreference = 'Stop'

$target = $env:COLOR_ANALYZER_INSTALL_DIR
if (-not $target) {
    $target = Join-Path $env:LOCALAPPDATA 'Programs\Color Analyzer'
}

if (-not (Test-Path -LiteralPath $ZipPath)) {
    throw "Portable payload was not found: $ZipPath"
}

New-Item -ItemType Directory -Path $target -Force | Out-Null
Expand-Archive -LiteralPath $ZipPath -DestinationPath $target -Force

$appExe = Join-Path $target 'Color Analyzer.exe'
if (-not (Test-Path -LiteralPath $appExe)) {
    throw "Installation completed without the application executable: $appExe"
}

if (-not $env:COLOR_ANALYZER_INSTALL_TEST) {
    $startMenu = Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs'
    New-Item -ItemType Directory -Path $startMenu -Force | Out-Null
    $shortcutPath = Join-Path $startMenu 'Color Analyzer.lnk'
    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $appExe
    $shortcut.WorkingDirectory = $target
    $shortcut.IconLocation = "$appExe,0"
    $shortcut.Description = 'Color Analyzer CPU'
    $shortcut.Save()
}

Write-Output "Installed Color Analyzer to $target"
