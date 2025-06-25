[![License](https://img.shields.io/badge/license-All%20Rights%20Reserved-red)](https://example.com/license)
[![Version](https://img.shields.io/badge/version-2.5-blue)](https://github.com/yourrepo)

# BSM (Basic System Maintenance) Script
This script performs various maintenance tasks on a Windows machine, including system file checks, image repair, and cache cleanup for multiple browsers.

## Features
- Runs System File Checker (SFC)
- Uses Deployment Image Servicing and Management (DISM)
- Flushes DNS cache
- Deletes temporary files
- Deletes Windows Restore Points
- Clears browser cache for Chrome, Edge, Brave, Opera, and Opera GX
- Clears the Downloads folder
- Deletes Explorer recent file list
- Clears Command Prompt history
- Deletes dump files
- Cleans application crash dumps
- Deletes old Windows Update logs
- Deletes old Windows event tracing logs
- Deletes Windows thumbnail cache
- Deletes Windows Event Log files
- Cleans up Windows Update files
- Deletes Epic Games cache
- Deletes Discord cache
- Deletes old prefetch data
- Empties Recycle Bin
- Generates a log file with timestamp after each run
- Plugin support – Run your own batch scripts inside the `plugins/` folder for custom functionality

## Usage Instructions
1. Download the BSM (Basic System Maintenance) script.
2. Place your batch files inside the `plugins/` folder.
3. Right-click the script and select `Run as Administrator` to allow it to perform system-level tasks.
4. Enter "scan" for a full scan, or a combination of the choices below:
 - Activate installed plugins [plugin]
 - Run System File Checker [1]
 - Run Deployment Image Servicing and Management [2]
 - Flush DNS cache [3]
 - Delete Temporary files [4]
 - Clear Downloads folder [5]
 - Clean Browser Cache [6]
 - Delete System Restore Points [7]
 - Delete Explorer recent file list [8]
 - Clear Command Prompt history [9]
 - Clear application crash dumps [10]
 - Delete old Windows Update logs [11]
 - Delete old Windows event tracing logs [12]
 - Delete Discord cache [13]
 - Delete Epic Games Launcher cache [14]
 - Delete all dump files [15]
 - Delete Windows thumbnail cache [16]
 - Delete Windows Event Log files [17]
 - Delete Windows Update files [18]
 - Delete old prefetch data [19]
 - Empty Recycle Bin [20]
5. Do not touch your personal computer until the scan ends.
6. After completion, check the desktop for `BSM_log.txt` for a timestamped record of the cleanup.

## License
© 2025 LB-Works™ – All Rights Reserved
