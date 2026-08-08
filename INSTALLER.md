# Color Analyzer Installer

`installer\Color-Analyzer-0.1.0-CPU-Installer.zip` is the named installer package for the CPU build. Extract the ZIP, then run `Color-Analyzer-0.1.0-Setup.exe` inside it.

## Install

Run the setup executable. It installs the application for the current Windows user at:

```text
%LOCALAPPDATA%\Programs\Color Analyzer
```

It also creates a Start Menu shortcut named `Color Analyzer`.

The installer does not require CUDA, Qt, OpenImageIO, CMake, Visual Studio, or administrator access.

## Rebuild

From the repository root, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\installer\build-installer.ps1 `
  -PortableZip "C:\path\to\Color-Analyzer-0.1.0-windows-x64-CPU-portable.zip"
```

The portable ZIP must contain the same CPU distribution as the repository root. The build script uses Windows IExpress, which is included with Windows, and writes the named installer ZIP to the `installer` directory.

## Remove

The application is user-scoped. To remove it, close the application, delete `%LOCALAPPDATA%\Programs\Color Analyzer`, and remove the `Color Analyzer` shortcut from the Start Menu.
