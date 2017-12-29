@echo off
openfiles > NUL 2>&1 
if NOT %ERRORLEVEL% EQU 0 goto :NotAdmin 
goto :mainmenu 
:NotAdmin
echo Please run as admin. Closing in 3 seconds.
TIMEOUT 3
GOTO :realend

echo Welcome to Staples Store #17 Tech Backup and Migrate script!

:mainmenu
echo ----------
echo ----------
echo MAIN MENU
echo 1. Backup Data
echo 2. Migrate Data [COMING SOON]
REM prompt between backup or migrate
SET /P backMigSel=What would you like to do?

REM if selection is 1, go to backup section
IF "%backMigSel%"=="1" GOTO :backup
REM if not a 1, start again
echo Not a valid selection, please try again.
GOTO :mainmenu

:backup
set /P backDestLet=What is the drive letter of the drive to put the backup unto? 
IF "%backDestLet%"=="c" GOTO :invalidletter
IF "%backDestLet%"=="C" GOTO :invalidletter
IF NOT EXIST "%backDestLet%:\" GOTO :invalidletter

echo Valid selection. Starting Backup in 3 seconds.
TIMEOUT 3

mkdir "%backDestLet%:\StaplesBackup"
mkdir "%backDestLet%:\StaplesBackup\Users"
robocopy "C:\Users" "%backDestLet%:\StaplesBackup\Users" /v /log:"%backDestLet%:\backupLog.txt" /e /zb /mt:4 /r:3 /w:3 /copy:dt /tee /eta /xj /xf "NETUSER.DAT" /xd "Local Settings" /xd "AppData" /xd "Application Data" /xd "C:\Users\All Users" /xd "C:\Default User" /xd "C:\Users\Default" /xd "C:\Users\DefaultAppPool" /xd "C:\Users\Default.migrated"
echo BACKUP COMPLETE. Displaying log file.
start "" "E:\backupLog.txt"
GOTO :end

:backupextrafolders
SET extracount=0
:extrabackupinput
SET /P backupExtraInput=Would you like to backup extra folders not present under Users[y/n]? 
IF "%backupExtraInput%"=="y" GOTO :extrabackuploop
IF "%backupExtraInput%"=="n" GOTO :end
echo Invalid selection, please type y or n.
GOTO :extrabackupinput

:extrabackuploop
SET /A extracount=extracount+1
SET backupExtraPath[0]="EMPTY"
mkdir "%backDestLet%:\StaplesBackup\Extra%extracount%"
SET /P backupExtraPath[extracount]=What is the full path of the extra folder (include drive letter and backslashes, NOT frontslashes) number %extracount%? 
SET /P backupExtraAgain=Add another folder to extra backups[y/n]? 
IF "%backupExtraAgain%"=="y" GOTO :extrabackuploop
IF "%backupExtraAgain%"=="n" GOTO :performextrabackup
echo Invalid selection, please type y or n.
GOTO :extrabackuploop

:performextrabackup
SET performcount=0
:performloop
SET /A performcount=performcount+1
echo Starting backup of extra folder number %performcount%
robocopy "backupExtraPath[performcount]" "%backDestLet%:\StaplesBackup\Extra%performcount%" /v /log:"%backDestLet%:\extraBackupLog%performcount%.txt" /e /zb /mt:4 /r:3 /w:3 /copy:dt /tee /eta /xj 
start "Extra %performcount%" "%backDestLet%:\extraBackupLog%performcount%.txt"

IF %performcount% LSS %extracount% GOTO :performloop
echo "EXTRA FOLDERS BACKUP COMPLETE. Displaying log file.

:end
echo TASKS COMPLETE. YOU HAVE REACHED THE END OF THE SCRIPT.
pause
:realend
