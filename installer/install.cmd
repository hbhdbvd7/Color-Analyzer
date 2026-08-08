@echo off
setlocal
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1" -ZipPath "%~dp0Color-Analyzer-0.1.0-windows-x64-CPU-portable.zip"
exit /b %ERRORLEVEL%
