@echo off
:: Check for admin privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo [!] Please run this script as Administrator.
    echo Right-click the script and choose "Run as administrator".
    pause
    exit /b
)
:menu
cls
echo "  .____   __________           __      __             __             TM "
echo "  |    |  \______   \         /  \    /  \___________|  | __  ______    "
echo "  |    |   |    |  _/  ______ \   \/\/   /  _ \_  __ \  |/ / /  ___/    "
echo "  |    |___|    |   \ /_____/  \        (  <_> )  | \/    <  \___ \     "
echo "  |_______ \______  /           \__/\  / \____/|__|  |__|_ \/____  >    "
echo "          \/      \/                 \/                   \/     \/     "
echo (c) 2025 LB-Works (TM) - All Rights Reserved
echo.
echo ---------------------------------------------------------------------------------------------
echo.
echo BSM (Basic System Maintenance) v2.5
echo WARNING: Please read README.ML before running this script.
set /p choices=Enter "scan" to run a Full scan. To activate Plugins, type "plugin" next to it. (to learn more, check README.ML)

for %%c in (%choices%) do (
    call :runChoice %%c
)

echo.
pause
goto menu
pause

:runChoice

if "%1"=="plugin" (
echo.
echo [*] Loading Plugins...
for %%F in ("plugins\*.bat") do (
    echo Running plugin: %%~nxF
    call "%%F"
    echo Finished: %%~nxF
)
)

if "%1"=="scan" (
:: Delete all system restore points
echo Deleting all system restore points...
vssadmin Delete Shadows /All /Quiet

:: Run System File Checker
echo Running System File Checker...
sfc /scannow

:: Run Deployment Image Servicing and Management
echo Running Deployment Image Servicing and Management...
DISM /Online /Cleanup-Image /RestoreHealth

:: Flush DNS cache
echo Flushing DNS cache...
ipconfig /flushdns

:: Delete temporary files
echo Deleting temporary files...
:: Delete temporary files from the current user's Temp folder
del /f /s /q "%temp%\*.*"

for /d %%x in (%temp%\*) do rd /s /q "%%x"
:: Delete temporary files from the system Temp folder
del /f /s /q "C:\Windows\Temp\*.*"

for /d %%x in (C:\Windows\Temp\*) do rd /s /q "%%x"

:: Clear Downloads folder
echo Clearing Downloads folder...
del /f /q "%USERPROFILE%\Downloads\*.*"

setlocal

echo Deleting browser caches...

:: Define user profile path
set "USER_PROFILE=%USERPROFILE%"
set "LOCALAPPDATA=%LOCALAPPDATA%"
set "APPDATA=%APPDATA%"

:: Close browsers before clearing caches
echo Closing browsers...

:: Close Chrome
taskkill /f /im chrome.exe >nul 2>&1

:: Close Edge
taskkill /f /im msedge.exe >nul 2>&1

:: Close Opera
taskkill /f /im opera.exe >nul 2>&1

:: Close Opera GX
taskkill /f /im opera_gx.exe >nul 2>&1

:: Close Brave
taskkill /f /im brave.exe >nul 2>&1

echo Browsers closed.

:: Now delete caches
echo Deleting browser caches...

:: Chrome
echo Clearing Chrome cache...
rmdir /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache"
rmdir /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Code Cache"

:: Edge
echo Clearing Edge cache...
rmdir /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache"
rmdir /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache"

:: Opera
echo Clearing Opera cache...
rmdir /s /q "%LOCALAPPDATA%\Opera Software\Opera Stable\Default\Cache"
rmdir /s /q "%LOCALAPPDATA%\Opera Software\Opera Stable\Default\System Cache"

:: Opera GX
echo Clearing Opera GX cache...
rmdir /s /q "%LOCALAPPDATA%\Opera Software\Opera GX Stable\Cache"
rmdir /s /q "%LOCALAPPDATA%\Opera Software\Opera GX Stable\System Cache"

:: Brave
echo Clearing Brave cache...
rmdir /s /q "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Cache"
rmdir /s /q "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Code Cache"

:: Delete Explorer recent file list
echo Deleting Explorer recent file list...
del /q "%appdata%\Microsoft\Windows\Recent\*.*"

:: Clear Command Prompt history
echo Clearing Command Prompt history...
doskey /reinstall > nul


:: Clear application crash dumps
echo Deleting application crash dumps...
del /q /f "%LOCALAPPDATA%\CrashDumps\*.*"
for /d %%x in ("%LOCALAPPDATA%\CrashDumps\*") do rd /s /q "%%x"


:: Delete old Windows Update logs
echo Deleting old Windows Update logs...
del /q /f "C:\Windows\SoftwareDistribution\DataStore\Logs\*.*"
for /d %%x in ("C:\Windows\SoftwareDistribution\DataStore\Logs\*") do rd /s /q "%%x"

:: Delete old Windows event tracing logs
echo Deleting old event tracing logs...
del /q /f "C:\Windows\Logs\*.*"
for /d %%x in ("C:\Windows\Logs\*") do rd /s /q "%%x"

:: Close Discord before clearing cache
echo Deleting Discord cache...
taskkill /f /im Discord.exe >nul 2>&1
rd /s /q "%APPDATA%\discord\Cache"
for /d %%x in ("%APPDATA%\discord\Cache\*") do rd /s /q "%%x"
rd /s /q "%APPDATA%\discord\Code Cache"
for /d %%x in ("%APPDATA%\discord\Code Cache\*") do rd /s /q "%%x"
rd /s /q "%APPDATA%\discord\GPUCache"
for /d %%x in ("%APPDATA%\discord\GPUCache\*") do rd /s /q "%%x"

:: Close Epic Games processes
echo Deleting Epic Games Launcher cache...
taskkill /f /im EpicGamesLauncher.exe >nul 2>&1
taskkill /f /im EpicWebHelper.exe >nul 2>&1
rd /s /q "%LOCALAPPDATA%\EpicGamesLauncher\Saved\webcache"
for /d %%x in ("%LOCALAPPDATA%\EpicGamesLauncher\Saved\webcache\*") do rd /s /q "%%x"
rd /s /q "%LOCALAPPDATA%\EpicGamesLauncher\Saved\webcache_4147"
for /d %%x in ("%LOCALAPPDATA%\EpicGamesLauncher\Saved\webcache_4147\*") do rd /s /q "%%x"
rd /s /q "%LOCALAPPDATA%\EpicGamesLauncher\Saved\Logs"
for /d %%x in ("%LOCALAPPDATA%\EpicGamesLauncher\Saved\Logs*") do rd /s /q "%%x"

:: Delete all dump files
echo Deleting dump files...
del /q /s C:\Windows\Minidump\*.*

:: Delete Windows thumbnail cache
echo Deleting Windows thumbnail cache...
del /q "C:\Users\%username%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db"

:: Delete Windows Event Log files
echo Deleting Windows Event Log files...
wevtutil cl Application
wevtutil cl System
wevtutil cl Security

:: Delete Windows Update files
echo Cleaning up Windows Update files...
dism /online /cleanup-image /startcomponentcleanup

:: Delete old prefetch data
echo Deleting old prefetch data...
del /f /s /q C:\Windows\Prefetch\*

:: Empty Recycle Bin
echo Emptying Recycle Bin...
powershell -command "Clear-RecycleBin -Force"

:: Scan log
echo [%date% %time%] Maintenance complete. >> "%USERPROFILE%\Desktop\BSM_log.txt"

pushd "%~dp0"
cscript //nologo "data\notification.vbs"
popd

pause
)

if "%1"=="1" (
:: Run System File Checker
echo Running System File Checker...
sfc /scannow
)

if "%1"=="2" (
:: Run Deployment Image Servicing and Management
echo Running Deployment Image Servicing and Management...
DISM /Online /Cleanup-Image /RestoreHealth
)

if "%1"=="3" (
:: Flush DNS cache
echo Flushing DNS cache...
ipconfig /flushdns
)

if "%1"=="4" (
:: Delete temporary files
echo Deleting temporary files...
:: Delete temporary files from the current user's Temp folder
del /f /s /q "%temp%\*.*"

for /d %%x in (%temp%\*) do rd /s /q "%%x"
:: Delete temporary files from the system Temp folder
del /f /s /q "C:\Windows\Temp\*.*"

for /d %%x in (C:\Windows\Temp\*) do rd /s /q "%%x"
)

if "%1"=="5" (
:: Clear Downloads folder
echo Clearing Downloads folder...
del /f /q "%USERPROFILE%\Downloads\*.*"
)

if "%1"=="6" (
setlocal

echo Deleting browser caches...

:: Define user profile path
set "USER_PROFILE=%USERPROFILE%"
set "LOCALAPPDATA=%LOCALAPPDATA%"
set "APPDATA=%APPDATA%"

:: Close browsers before clearing caches
echo Closing browsers...

:: Close Chrome
taskkill /f /im chrome.exe >nul 2>&1

:: Close Edge
taskkill /f /im msedge.exe >nul 2>&1

:: Close Opera
taskkill /f /im opera.exe >nul 2>&1

:: Close Opera GX
taskkill /f /im opera_gx.exe >nul 2>&1

:: Close Brave
taskkill /f /im brave.exe >nul 2>&1

:: Now delete caches
echo Deleting browser caches...

:: Chrome
echo Clearing Chrome cache...
rmdir /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache"
rmdir /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Code Cache"

:: Edge
echo Clearing Edge cache...
rmdir /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache"
rmdir /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache"

:: Opera
echo Clearing Opera cache...
rmdir /s /q "%LOCALAPPDATA%\Opera Software\Opera Stable\Default\Cache"
rmdir /s /q "%LOCALAPPDATA%\Opera Software\Opera Stable\Default\System Cache"

:: Opera GX
echo Clearing Opera GX cache...
rmdir /s /q "%LOCALAPPDATA%\Opera Software\Opera GX Stable\Cache"
rmdir /s /q "%LOCALAPPDATA%\Opera Software\Opera GX Stable\System Cache"

:: Brave
echo Clearing Brave cache...
rmdir /s /q "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Cache"
rmdir /s /q "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Code Cache"

echo Cache cleanup complete.
)

if "%1"=="7" (
:: Delete all system restore points
echo Deleting all system restore points...
vssadmin Delete Shadows /All /Quiet
)

if "%1"=="8" (
:: Delete Explorer recent file list
echo Deleting Explorer recent file list...
del /q "%appdata%\Microsoft\Windows\Recent\*.*"
)

if "%1"=="9" (
:: Clear Command Prompt history
echo Clearing Command Prompt history...
doskey /reinstall > nul
)

if "%1"=="10" (
:: Clear application crash dumps
echo Deleting application crash dumps...
del /q /f "%LOCALAPPDATA%\CrashDumps\*.*"
for /d %%x in ("%LOCALAPPDATA%\CrashDumps\*") do rd /s /q "%%x"
)

if "%1"=="11" (
:: Delete old Windows Update logs
echo Deleting old Windows Update logs...
del /q /f "C:\Windows\SoftwareDistribution\DataStore\Logs\*.*"
for /d %%x in ("C:\Windows\SoftwareDistribution\DataStore\Logs\*") do rd /s /q "%%x"
)

if "%1"=="12" (
:: Delete old Windows event tracing logs
echo Deleting old event tracing logs...
del /q /f "C:\Windows\Logs\*.*"
for /d %%x in ("C:\Windows\Logs\*") do rd /s /q "%%x"
)

if "%1"=="13" (
:: Close Discord before clearing cache
echo Deleting Discord cache...
taskkill /f /im Discord.exe >nul 2>&1
rd /s /q "%APPDATA%\discord\Cache"
for /d %%x in ("%APPDATA%\discord\Cache\*") do rd /s /q "%%x"
rd /s /q "%APPDATA%\discord\Code Cache"
for /d %%x in ("%APPDATA%\discord\Code Cache\*") do rd /s /q "%%x"
rd /s /q "%APPDATA%\discord\GPUCache"
for /d %%x in ("%APPDATA%\discord\GPUCache\*") do rd /s /q "%%x"
)

if "%1"=="14" (
:: Close Epic Games processes
echo Deleting Epic Games Launcher cache...
taskkill /f /im EpicGamesLauncher.exe >nul 2>&1
taskkill /f /im EpicWebHelper.exe >nul 2>&1
rd /s /q "%LOCALAPPDATA%\EpicGamesLauncher\Saved\webcache"
for /d %%x in ("%LOCALAPPDATA%\EpicGamesLauncher\Saved\webcache\*") do rd /s /q "%%x"
rd /s /q "%LOCALAPPDATA%\EpicGamesLauncher\Saved\webcache_4147"
for /d %%x in ("%LOCALAPPDATA%\EpicGamesLauncher\Saved\webcache_4147\*") do rd /s /q "%%x"
rd /s /q "%LOCALAPPDATA%\EpicGamesLauncher\Saved\Logs"
for /d %%x in ("%LOCALAPPDATA%\EpicGamesLauncher\Saved\Logs*") do rd /s /q "%%x"
)

if "%1"=="15" (
:: Delete all dump files
echo Deleting dump files...
del /q /s C:\Windows\Minidump\*.*
)

if "%1"=="16" (
:: Delete Windows thumbnail cache
echo Deleting Windows thumbnail cache...
del /q "C:\Users\%username%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db"
)

if "%1"=="17" (
:: Delete Windows Event Log files
echo Deleting Windows Event Log files...
wevtutil cl Application
wevtutil cl System
wevtutil cl Security
)

if "%1"=="18" (
:: Delete Windows Update files
echo Cleaning up Windows Update files...
dism /online /cleanup-image /startcomponentcleanup
)

if "%1"=="19" (
:: Delete old prefetch data
echo Deleting old prefetch data...
del /f /s /q C:\Windows\Prefetch\*
)

if "%1"=="20" (
:: Empty Recycle Bin
echo Emptying Recycle Bin...
powershell -command "Clear-RecycleBin -Force"
)

pause
