# Color Analyzer Installer

`installer\Color-Analyzer-0.1.0-CPU-Installer.zip` is the named installer package for the CPU build. Extract the ZIP, then run `Color-Analyzer-0.1.0-Setup.exe` inside it.

## Install

Run the setup executable to open the standard Windows installation wizard. It requires administrator permission and defaults to:

```text
C:\Program Files\Color Analyzer
```

The wizard lets you choose another installation path and optionally creates a desktop shortcut. A Start Menu shortcut named `Color Analyzer` is created automatically.

The installed program does not require CUDA, Qt, OpenImageIO, CMake, Visual Studio, or NVIDIA drivers.

## Rebuild

From the repository root, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\installer\build-installer.ps1 `
  -IsccPath "C:\path\to\Inno Setup 6\ISCC.exe"
```

The build script uses Inno Setup and packages the CPU distribution from the repository root. It writes the named installer ZIP to the `installer` directory.

## Remove

Use Windows Settings > Apps or Control Panel > Programs and Features to uninstall `Color Analyzer`.
