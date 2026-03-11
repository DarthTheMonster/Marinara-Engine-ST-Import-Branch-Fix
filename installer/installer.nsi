; Marinara Engine — NSIS Installer Wrapper
; Compiles install.bat into a self-extracting .exe

!include "MUI2.nsh"

Name "Marinara Engine"
OutFile "Marinara-Engine-Installer-1.3.0.exe"
Unicode True
RequestExecutionLevel user
ShowInstDetails show

; ── Branding ──
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\orange-install.ico"
!define MUI_ABORTWARNING
BrandingText "Marinara Engine v1.3.0"

; ── Pages ──
!insertmacro MUI_PAGE_INSTFILES

; ── Language ──
!insertmacro MUI_LANGUAGE "English"

Section "Install"
    ; Use LOCALAPPDATA instead of TEMP — Windows Defender on Win10
    ; often quarantines .bat files extracted to TEMP by unsigned executables
    SetOutPath "$LOCALAPPDATA\marinara-installer"
    File "install.bat"

    DetailPrint "Running Marinara Engine installer..."
    DetailPrint "A command prompt window will open — follow the prompts there."
    DetailPrint ""

    ; Launch install.bat in its own interactive console window.
    ; 'start "" /wait' forces a new visible console — ExecWait alone
    ; sometimes fails to show a window when called from an NSIS GUI process.
    ExecWait '"$SYSDIR\cmd.exe" /c start "Marinara Engine Installer" /wait "$LOCALAPPDATA\marinara-installer\install.bat"'

    ; Clean up
    Delete "$LOCALAPPDATA\marinara-installer\install.bat"
    RMDir "$LOCALAPPDATA\marinara-installer"
SectionEnd
