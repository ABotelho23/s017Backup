@echo off
openfiles > NUL 2>&1 
if NOT %ERRORLEVEL% EQU 0 goto :NotAdmin 
goto :mainmenu 
:NotAdmin
echo Please run as admin. Closing in 10 seconds.
TIMEOUT 10
GOTO :realend

echo Welcome to Staples Store #17 Tech Backup and Migrate script!

:mainmenu
echo ----------
echo ----------
echo MAIN MENU
echo 1. Backup Data
echo 2. Migrate Data [COMING SOON]
echo 3. Migrate Data (Custom) [COMING SOON]
set /P backMigSel=What would you like to do? 

IF "%backMigSel%"=="1" GOTO :backup
IF "%backMigSel%"=="2" GOTO :migration
echo Not a valid selection, please try again.
GOTO :mainmenu

:backup
set /P backDestLet=What is the drive letter of the drive to put the backup unto? 
IF "%backDestLet%"=="c" GOTO :cantusec
IF "%backDestLet%"=="C" GOTO :cantusec
IF NOT EXIST "%backDestLet%:\" GOTO :invalidletter

echo Valid selection. Starting Backup in 3 seconds.
TIMEOUT 3

mkdir "%backDestLet%:\StaplesBackup"
mkdir %backDestLet%:\StaplesBackup\Backup"
mkdir %backDestLet%:\StaplesBackup\Backup\StaplesBackup"
robocopy "C:\Users" "%backDestLet%:\StaplesBackup\Backup\Users" /v /log:"%backDestLet%:\StaplesBackup\backupLog.txt" /e /zb /mt:4 /r:3 /w:3 /copy:dt /tee /eta /xj /xf "NETUSER.DAT" /xd "Local Settings" /xd "AppData" /xd "Application Data" /xd "C:\Users\All Users" /xd "C:\Default User" /xd "C:\Users\Default" /xd "C:\Users\DefaultAppPool" /xd "C:\Users\Default.migrated"
echo BACKUP COMPLETE. Displaying log file.
start "" "%backDestLet%:\StaplesBackup\backupLog.txt"
GOTO :end

:migration

:cantusec
echo C: drive cannot be used as a destination, please select another drive
GOTO :backup

:invalidletter
echo A drive with that letter is not connected. Please check the letter and try again.
GOTO :backup

:end
pause
:realend
