:: JunkwareRemover
:: Created by Thisisu
@echo OFF
title JunkwareRemover - Version 1.0.1
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
ECHO %OS%|FIND "Windows XP" >NUL
IF %ERRORLEVEL% EQU 0 (
 SET "LOCALA=%userprofile%\Local Settings\Application Data"
 SET "MYDOCS=%userprofile%\My Documents"
 SET "MYDLS=%userprofile%\My Documents\Downloads"
 SET "MYMUSIC=%userprofile%\My Documents\My Music"
 SET "LNK1XP=%allusersprofile%\Start Menu"
 SET "LNK2XP=%userprofile%\Start Menu"
 SET "STARTUP=%userprofile%\Start Menu\Programs\Startup"
 SET "DRM=%allusersprofile%\DRM"
 SET "TIFS=%systemdrive%\Documents and Settings\LocalService\Local Settings\Temporary Internet Files\Content.IE5"
 SET "TIFS2=%windir%\System32\config\systemprofile\Local Settings\Temporary Internet Files\Content.IE5"
) ELSE (
 SET "LOCALA=%localappdata%"
 SET "LOCALLOW=%userprofile%\Appdata\LocalLow"
 SET "MYDOCS=%userprofile%\Documents"
 SET "MYDLS=%userprofile%\Downloads"
 SET "MYMUSIC=%userprofile%\Music"
 SET "PUBDESKTOP=%systemdrive%\Users\Public\Desktop"
 SET "PUBDOCS=%systemdrive%\users\Public\Documents"
 SET "PUBLIC=%systemdrive%\Users\Public"
 SET "QUICKLAUNCH17=%appdata%\Microsoft\Internet Explorer\Quick Launch\User Pinned\StartMenu"
 SET "QUICKLAUNCH27=%appdata%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
 SET "PROGRAMS17=%allusersprofile%\Microsoft\Windows\Start Menu\Programs"
 SET "PROGRAMS27=%appdata%\Microsoft\Windows\Start Menu\Programs"
 SET "STARTMENU17=%allusersprofile%\Microsoft\windows\Start Menu"
 SET "STARTMENU27=%appdata%\Microsoft\Windows\Start Menu"
 SET "STARTUP=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"
 SET "DRM=%allusersprofile%\Microsoft\DRM"
 SET "TIFS=%localappdata%\Microsoft\Windows\Temporary Internet Files\Content.IE5"
 SET "TIFS2=%windir%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\Temporary Internet Files\Content.IE5"
)

:: WarcraftLogs
DEL /F/Q "%PROGRAMFILES(x86)%\World of Warcraft\_retail_\Logs\RaiderIOLogsArchive\*" >NUL 2>&1
DEL /F/Q "%PROGRAMFILES(x86)%\World of Warcraft\_xptr_\Logs\*" >NUL 2>&1
DEL /F/Q "%PROGRAMFILES(x86)%\World of Warcraft\_retail_\Logs\WoWCombat*.txt" >NUL 2>&1

:: Microsoft Edge Uninstaller
TASKKILL /F /IM "msedge.exe" >NUL 2>&1
REG DELETE "HKLM\SYSTEM\CurrentControlSet\services\edgeupdate" /F >NUL 2>&1
REG DELETE "HKLM\SYSTEM\CurrentControlSet\services\edgeupdatem" /F >NUL 2>&1
REG DELETE "HKLM\SYSTEM\CurrentControlSet\services\MicrosoftEdgeElevationService" /F >NUL 2>&1

RD /S/Q "%PROGRAMFILES(x86)%\Microsoft\Edge" >NUL 2>&1
RD /S/Q "%PROGRAMFILES(x86)%\Microsoft\EdgeCore" >NUL 2>&1
RD /S/Q "%PROGRAMFILES(x86)%\Microsoft\EdgeUpdate" >NUL 2>&1
RD /S/Q "%userprofile%\MicrosoftEdgeBackups" >NUL 2>&1
RD /S/Q "%LOCALLOW%\Microsoft\Internet Explorer" >NUL 2>&1

DEL /F/Q "%APPDATA%\discord\Cache\Cache_Data\*" >NUL 2>&1
DEL /F/Q "%APPDATA%\discord\Code Cache\js\*" >NUL 2>&1
DEL /F/Q "%USERPROFILE%\Desktop\Microsoft Edge.lnk" >NUL 2>&1
DEL /F/Q "%PROGRAMS27%\Microsoft Edge.lnk" >NUL 2>&1
DEL /F/Q "%userprofile%\Favorites\Bing.url" >NUL 2>&1
DEL /F/Q "%QUICKLAUNCHALL%\*.lnk" >NUL 2>&1
DEL /F/Q/S "%WINDIR%\Logs\*.etl" >NUL 2>&1
DEL /F/Q/S "%WINDIR%\Logs\*.log" >NUL 2>&1