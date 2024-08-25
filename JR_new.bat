:: JunkwareRemover
:: Created by Furtivex
@echo OFF && color 17
title JunkwareRemover - Version 1.0.5
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
SET "QUICKLAUNCHALL=%appdata%\Microsoft\Internet Explorer\Quick Launch"
SET "PROGRAMS1ALL=%allusersprofile%\Start Menu\Programs"
SET "PROGRAMS2ALL=%userprofile%\Start Menu\Programs"
if exist "%windir%\Sysnative\cmd.exe" ( SET "SYS32=%windir%\Sysnative" ) else ( SET "SYS32=%windir%\System32" )
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
if exist %windir%\syswow64 ( set ARCH=x64 ) else ( set ARCH=x86 )
if %ARCH%==x64 (
 SET "SYSWOW64=%windir%\SysWOW64"
)
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
SET "LOCALA=%localappdata%"
SET "LOCALLOW=%userprofile%\Appdata\LocalLow"
SET "PROGRAMS17=%allusersprofile%\Microsoft\Windows\Start Menu\Programs"
SET "PROGRAMS27=%appdata%\Microsoft\Windows\Start Menu\Programs"
SET "PUBDESKTOP=%systemdrive%\Users\Public\Desktop"
SET "QUICKLAUNCH17=%appdata%\Microsoft\Internet Explorer\Quick Launch\User Pinned\StartMenu"
SET "QUICKLAUNCH27=%appdata%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
SET "STARTMENU17=%allusersprofile%\Microsoft\windows\Start Menu"
SET "STARTMENU27=%appdata%\Microsoft\Windows\Start Menu"
SET "STARTUP=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"

:: Processes
TASKKILL /F /IM "msedge.exe" >NUL 2>&1

:: Registry
IF NOT EXIST %SYS32%\reg.exe GOTO :Tasks

if %ARCH%==x64 (
                 for %%i in (
"HKLM\SOFTWARE\WOW6432Node\Clients\StartMenuInternet\Microsoft Edge"
"HKLM\SOFTWARE\WOW6432Node\Microsoft\Edge"
"HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate"
"HKLM\SOFTWARE\WOW6432Node\Microsoft\OneDrive"
"HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge"
"HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update"
"HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView"
) DO (
       REG DELETE %%i /F >NUL 2>&1
      )
)

for %%i in (
"HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView"
"HKCU\Software\Microsoft\Xbox"
"HKCU\Software\Microsoft\XboxLive"
"HKLM\SOFTWARE\Clients\StartMenuInternet\Microsoft Edge"
"HKLM\SOFTWARE\Microsoft\Xbox"
) DO (
       REG DELETE %%i /F >NUL 2>&1
      )
)

IF NOT EXIST %SYS32%\findstr.exe GOTO :Tasks
IF NOT EXIST %WINDIR%\sed.exe GOTO :Tasks
REG QUERY "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"|FINDSTR /i "MicrosoftEdgeAutoLaunch">"%TEMP%\trash.txt"
IF %ERRORLEVEL% EQU 1 ( GOTO :Tasks )
SED -r "s/^\s{4}//;s/\s+REG_SZ\s+.*//g" <"%TEMP%\trash.txt" >"%TEMP%\trash2.txt"
for /f "usebackq delims=" %%i in ("%TEMP%\trash2.txt") DO (
    REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /V "%%i" /F >NUL 2>&1
)

:: Tasks
:Tasks
IF NOT EXIST %SYS32%\schtasks.exe GOTO :Services
for %%i in (
"MicrosoftEdgeUpdateTaskMachineCore"
"MicrosoftEdgeUpdateTaskMachineUA"
"Microsoft\Windows\Maintenance\WinSAT"
"Microsoft\XblGameSave"
"Microsoft\XblGameSave\XblGameSaveTask"
) DO (
       SCHTASKS /DELETE /TN %%i /F >NUL 2>&1
      )
)

:: Services
:Services
IF NOT EXIST %SYS32%\reg.exe GOTO :Files
for %%i in (
"HKLM\SYSTEM\CurrentControlSet\services\edgeupdate"
"HKLM\SYSTEM\CurrentControlSet\services\edgeupdatem"
"HKLM\SYSTEM\CurrentControlSet\services\MicrosoftEdgeElevationService"
) DO (
       REG DELETE %%i /F >NUL 2>&1
      )
)

:: Files
:Files
for %%i in (
"%USERPROFILE%\Desktop\Microsoft Edge.lnk"
"%PROGRAMS27%\Microsoft Edge.lnk"
"%USERPROFILE%\Favorites\Bing.url"
"%TEMP%\trash*.txt"
) DO (
       DEL /F/Q %%i >NUL 2>&1
      )
)

:: Folders
for %%i in (
"%LOCALA%\MicrosoftEdge"
"%LOCALA%\Microsoft\Edge"
"%LOCALA%\Microsoft\OneDrive"
"%LOCALA%\Microsoft\XboxLive"
"%PROGRAMFILES%\Microsoft\EdgeUpdater"
"%PROGRAMFILES(x86)%\Microsoft\Edge"
"%PROGRAMFILES(x86)%\Microsoft\EdgeCore"
"%PROGRAMFILES(x86)%\Microsoft\EdgeUpdate"
"%PROGRAMFILES(x86)%\Microsoft\EdgeWebView"
"%USERPROFILE%\MicrosoftEdgeBackups"
) DO (
      RD /S/Q %%i >NUL 2>&1
      )
)

:eof