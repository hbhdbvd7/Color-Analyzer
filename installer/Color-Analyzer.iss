#define AppVersion "0.1.0"

#ifndef OutputDir
#define OutputDir "."
#endif

[Setup]
AppId={{A7C0F3C8-EE3C-4AC1-8D91-0C8CA9E5F1B0}
AppName=Color Analyzer
AppVersion={#AppVersion}
AppVerName=Color Analyzer {#AppVersion} CPU
AppPublisher=Color Analyzer
AppPublisherURL=https://github.com/hbhdbvd7/Color-Analyzer
AppSupportURL=https://github.com/hbhdbvd7/Color-Analyzer
DefaultDirName={autopf}\Color Analyzer
DefaultGroupName=Color Analyzer
DisableProgramGroupPage=yes
PrivilegesRequired=admin
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
OutputDir={#OutputDir}
OutputBaseFilename=Color-Analyzer-0.1.0-Setup
SetupIconFile=..\color_analyzer_rgb_additive_kaleidoscope_v2.ico
UninstallDisplayIcon={app}\Color Analyzer.exe
Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern
VersionInfoDescription=Color Analyzer CPU Installer
VersionInfoProductName=Color Analyzer
VersionInfoProductVersion={#AppVersion}
VersionInfoCompany=Color Analyzer
DirExistsWarning=no

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional shortcuts:"

[Files]
Source: "..\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "installer\*,.git\*"

[Icons]
Name: "{autoprograms}\Color Analyzer"; Filename: "{app}\Color Analyzer.exe"; WorkingDir: "{app}"; IconFilename: "{app}\Color Analyzer.exe"
Name: "{autodesktop}\Color Analyzer"; Filename: "{app}\Color Analyzer.exe"; WorkingDir: "{app}"; IconFilename: "{app}\Color Analyzer.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\Color Analyzer.exe"; Description: "Launch Color Analyzer"; WorkingDir: "{app}"; Flags: nowait postinstall skipifsilent
