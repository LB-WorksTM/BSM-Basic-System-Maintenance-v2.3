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
echo BSM (Basic System Maintenance) v2.3
echo WARNING: Please read README.ML before running this script.
pause

:: Run System File Checker
echo Running System File Checker...
sfc /scannow

:: Run Deployment Image Servicing and Management
echo Running Deployment Image Servicing and Management...
DISM /Online /Cleanup-Image /RestoreHealth

:: Delete temporary files
echo Deleting temporary files...
:: Delete temporary files from the current user's Temp folder
del /f /s /q "%temp%\*.*"

for /d %%x in (%temp%\*) do rd /s /q "%%x"
:: Delete temporary files from the system Temp folder
del /f /s /q "C:\Windows\Temp\*.*"

for /d %%x in (C:\Windows\Temp\*) do rd /s /q "%%x"
echo Temporary files deleted.

:: Clear Downloads folder
echo Clearing Downloads folder...
del /f /q "%USERPROFILE%\Downloads\*.*"
echo Downloads folder cleared.

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

echo Cache cleanup complete.

:: Delete all system restore points
echo Deleting all system restore points...
vssadmin Delete Shadows /All /Quiet

if %errorlevel% equ 0 (
    echo All restore points have been deleted successfully.
) else (
    echo Failed to delete restore points.
)

:: Delete Explorer recent file list
echo Deleting Explorer recent file list...
del /q "%appdata%\Microsoft\Windows\Recent\*.*"

if %errorlevel% equ 0 (
    echo Explorer recent file list deleted successfully.
) else (
    echo Failed to delete Explorer recent file list.
)

:: Clear Command Prompt history
echo Clearing Command Prompt history...
doskey /reinstall > nul
echo Command Prompt history cleared.

:: Clear application crash dumps
echo Deleting application crash dumps...
del /q /f "%LOCALAPPDATA%\CrashDumps\*.*"
for /d %%x in ("%LOCALAPPDATA%\CrashDumps\*") do rd /s /q "%%x"
echo Application crash dumps deleted.

:: Delete old Windows Update logs
echo Deleting old Windows Update logs...
del /q /f "C:\Windows\SoftwareDistribution\DataStore\Logs\*.*"
for /d %%x in ("C:\Windows\SoftwareDistribution\DataStore\Logs\*") do rd /s /q "%%x"
echo Old Windows Update logs deleted.

:: Delete old Windows event tracing logs
echo Deleting old event tracing logs...
del /q /f "C:\Windows\Logs\*.*"
for /d %%x in ("C:\Windows\Logs\*") do rd /s /q "%%x"
echo Event tracing logs deleted.

:: Close Discord before clearing cache
echo Deleting Discord cache...
taskkill /f /im Discord.exe >nul 2>&1
rd /s /q "%APPDATA%\discord\Cache"
for /d %%x in ("%APPDATA%\discord\Cache\*") do rd /s /q "%%x"
rd /s /q "%APPDATA%\discord\Code Cache"
for /d %%x in ("%APPDATA%\discord\Code Cache\*") do rd /s /q "%%x"
rd /s /q "%APPDATA%\discord\GPUCache"
for /d %%x in ("%APPDATA%\discord\GPUCache\*") do rd /s /q "%%x"
echo Discord cache deleted.

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
echo Epic Games Launcher cache deleted.

:: Delete all dump files
echo Deleting dump files...
del /q /s C:\Windows\Minidump\*.*
echo Dump files deleted.

:: Delete Windows thumbnail cache
echo Deleting Windows thumbnail cache...
del /q "C:\Users\%username%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db"
echo Windows thumbnail cache deleted.

:: Delete Windows Event Log files
echo Deleting Windows Event Log files...
wevtutil cl Application
wevtutil cl System
wevtutil cl Security
echo Windows Event Log files deleted.

:: Delete Windows Update files
echo Cleaning up Windows Update files...
dism /online /cleanup-image /startcomponentcleanup
echo Windows Update files cleaned up.

:: Delete old prefetch data
echo Deleting old prefetch data...
del /f /s /q C:\Windows\Prefetch\*
echo Old prefetch data deleted.

:: Empty Recycle Bin
echo Emptying Recycle Bin...
powershell -command "Clear-RecycleBin -Force"
echo Recycle Bin emptied..

:: Scan log
echo [%date% %time%] Maintenance complete. >> "%USERPROFILE%\Desktop\BSM_log.txt"

echo Done!
pause
