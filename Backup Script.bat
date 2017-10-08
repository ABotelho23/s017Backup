@echo off
echo Welcome to Staples Store #17 Tech Backup and Migrate script
:mainmenu
echo Main Menu
echo 1. Backup Data
echo 2. Migrate Data [COMING SOON]

set /P backMigSel=What would you like to do? 

IF "%backMigSel%"=="1" GOTO :backup
echo Not a valid selection, please try again.
GO TO :mainmenu

:backup
set /P backDestLet=What is the drive letter of the drive to put the backup unto? 
mkdir "%backDestLet%:\StaplesBackup"
mkdir %backDestLet%:\StaplesBackup\Users"
robocopy "C:\Users" "%backDestLet%:\StaplesBackup\Users" /v /log:"%backDestLet%:\backupLog.txt" /e /zb /mt:4 /r:3 /w:3 /copy:dt /tee /eta /xj /xf "NETUSER.DAT" /xd "Local Settings" /xd "AppData" /xd "Application Data" /xd "C:\Users\All Users" /xd "C:\Default User" /xd "C:\Users\Default" /xd "C:\Users\DefaultAppPool" /xd "C:\Users\Default.migrated"
echo "BACKUP COMPLETE. Displaying log file.
start "" "E:\backupLog.txt"
GOTO :end

:end
