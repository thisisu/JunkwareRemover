:: JunkwareRemover
:: Created by Furtivex
@echo OFF
title JunkwareRemover - Version 1.0.3
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
SET "jr=%TEMP%\jr"
SET "JRTEMP=%TEMP%\jr\TEMP"
SET "GREP=%temp%\jr\GREP.DAT"
SET "SED=%temp%\jr\SED.DAT"
SET "SORT_=%temp%\jr\SORT_.DAT"
SET "CUT=%temp%\jr\CUT.DAT"
SET "SHORTCUT=%temp%\jr\SHORTCUT.DAT"
SET "WGET=%temp%\jr\WGET.DAT"
SET "NIRCMD=%temp%\jr\NIRCMD.DAT"
SET "QUICKLAUNCHALL=%appdata%\Microsoft\Internet Explorer\Quick Launch"
SET "PROGRAMS1ALL=%allusersprofile%\Start Menu\Programs"
REM PROGRAMS1ALL contains both folders and .lnk files. http://imgur.com/tnT8DZu
SET "PROGRAMS2ALL=%userprofile%\Start Menu\Programs"
REM PROGRAMS2ALL contains both folders (limited) and .LNK files. http://imgur.com/b71EmoM
if exist "%windir%\Sysnative\cmd.exe" ( SET "SYS32=%windir%\Sysnative" ) else ( SET "SYS32=%windir%\System32" )
SET "TASKS=%windir%\Tasks"
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
if exist %windir%\syswow64 ( set ARCH=x64 ) else ( set ARCH=x86 )
if %ARCH%==x64 (
 SET "SYSWOW64=%windir%\SysWOW64"
)
REM ~~~~~~~~~~~~~~~~~~~~~~~~>
FOR /F "tokens=2*" %%A IN ('REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName" /v ComputerName 2^>NUL') DO SET COMPUTERNAME=%%B
FOR /F "tokens=2*" %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName 2^>NUL') DO SET OS=%%B
SET "LOCALA=%localappdata%"
SET "LOCALLOW=%userprofile%\Appdata\LocalLow"
SET "MYDLS=%userprofile%\Downloads"
SET "MYDOCS=%userprofile%\Documents"
SET "MYMUSIC=%userprofile%\Music"
SET "PROGRAMS17=%allusersprofile%\Microsoft\Windows\Start Menu\Programs"
SET "PROGRAMS27=%appdata%\Microsoft\Windows\Start Menu\Programs"
SET "PUBDESKTOP=%systemdrive%\Users\Public\Desktop"
SET "PUBDOCS=%systemdrive%\users\Public\Documents"
SET "PUBLIC=%systemdrive%\Users\Public"
SET "QUICKLAUNCH17=%appdata%\Microsoft\Internet Explorer\Quick Launch\User Pinned\StartMenu"
SET "QUICKLAUNCH27=%appdata%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
SET "STARTMENU17=%allusersprofile%\Microsoft\windows\Start Menu"
SET "STARTMENU27=%appdata%\Microsoft\Windows\Start Menu"
SET "STARTUP=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"
SET "TIFS2=%windir%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\Temporary Internet Files\Content.IE5"
SET "TIFS=%localappdata%\Microsoft\Windows\Temporary Internet Files\Content.IE5"



:: Processes

TASKKILL /F /IM "msedge.exe" >NUL 2>&1

:: Tasks
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

for %%i in (
"HKLM\SYSTEM\CurrentControlSet\services\edgeupdate"
"HKLM\SYSTEM\CurrentControlSet\services\edgeupdatem"
"HKLM\SYSTEM\CurrentControlSet\services\MicrosoftEdgeElevationService"
) DO (
       REG DELETE %%i /F >NUL 2>&1
      )
)

:: Files

for %%i in (
"%PROGRAMFILES(x86)%\World of Warcraft\_retail_\Logs\RaiderIOLogsArchive\*"
"%PROGRAMFILES(x86)%\World of Warcraft\_xptr_\Logs\*"
"%PROGRAMFILES(x86)%\World of Warcraft\_retail_\Logs\WoWCombat*.txt"
"%APPDATA%\discord\Cache\Cache_Data\*"
"%APPDATA%\discord\Code Cache\js\*"
"%USERPROFILE%\Desktop\Microsoft Edge.lnk"
"%PROGRAMS27%\Microsoft Edge.lnk"
"%USERPROFILE%\Favorites\Bing.url"
) DO (
      DEL /F/Q %%i >NUL 2>&1
     )
)

:: Folders
for %%i in (
"%LOCALA%\Microsoft\Edge"
"%LOCALA%\Microsoft\XboxLive"
"%PROGRAMFILES%\Microsoft\EdgeUpdater"
"%PROGRAMFILES(x86)%\Microsoft\Edge"
"%PROGRAMFILES(x86)%\Microsoft\EdgeCore"
"%PROGRAMFILES(x86)%\Microsoft\EdgeUpdate"
"%USERPROFILE%\MicrosoftEdgeBackups"
) DO (
      IF EXIST %%i (
                     RD /S/Q %%i >NUL 2>&1
                    )
)