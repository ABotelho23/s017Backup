@echo off
openfiles > NUL 2>&1
if NOT %ERRORLEVEL% EQU 0 goto :NotAdmin
goto :mainmenu
:NotAdmin
echo PLEASE RUN AS ADMIN. Closing in 10 seconds.
TIMEOUT 10
GOTO :realend

echo Welcome to the Staples Store #17 Tech Services Backup and Migration script!

:mainmenu
echo ----------
echo ----------
echo MAIN MENU - What would you like to do?
echo 1. Backup Data
echo 2. Migrate Data [experimental]
echo 3. Migrate Data (Custom) [COMING SOON]
set /P backMigSel=What would you like to do?

IF "%backMigSel%"=="1" GOTO :backup
IF "%backMigSel%"=="2" GOTO :migration
IF "%backMigSel%"=="3" GOTO :migrationcustom
echo That is not a valid selection, please try again.
GOTO :mainmenu

:backup
set /P backDestLet=What is the drive letter of the drive to put the backup unto?
IF "%backDestLet%"=="c" GOTO :cantusecback
IF "%backDestLet%"=="C" GOTO :cantusecback
IF NOT EXIST "%backDestLet%:\" GOTO :invalidletterback

echo Valid selection. Starting Backup in 3 seconds.
TIMEOUT 3
echo STARTING BACKUP.

mkdir "%backDestLet%:\StaplesBackup"
mkdir %backDestLet%:\StaplesBackup\Backup"
mkdir %backDestLet%:\StaplesBackup\Backup\StaplesBackup"
robocopy "C:\Users" "%backDestLet%:\StaplesBackup\Backup\Users" /v /log:"%backDestLet%:\StaplesBackup\backupLog.txt" /e /zb /mt:4 /r:3 /w:3 /copy:dt /tee /eta /xj /xf "NETUSER.DAT" /xd "Local Settings" /xd "AppData" /xd "Application Data" /xd "C:\Users\All Users" /xd "C:\Default User" /xd "C:\Users\Default" /xd "C:\Users\DefaultAppPool" /xd "C:\Users\Default.migrated"
echo BACKUP COMPLETE. Displaying log file.
start "" "%backDestLet%:\StaplesBackup\backupLog.txt"
GOTO :end

:migration
set /P migSrcLet=What is the drive letter of the drive to migrate from?
IF "%migSrcLet%"=="c" GOTO :cantusecmig
IF "%migSrcLet%"=="C" GOTO :cantusecmig
IF NOT EXIST "%migSrcLet%:\" GOTO :invalidlettermig
IF NOT EXIST "%migSrcLet%:\" GOTO :nobackupfound

echo Valid selection. Starting Migration in 3 seconds.
TIMEOUT 3
echo STARTING MIGRATION.

robocopy "%migSrcLet%:\StaplesBackup\Backup\Users" "C:\Users" /v /log:"C:\Users\migrationLog.txt" /e /zb /mt:4 /r:3 /w:3 /copy:dt /tee /eta
echo MIGRATION COMPLETE. Displaying log file.
start "" "C:\Users\migrationLog.txt"
GOTO :end

:migrationcustom
echo Custom migrations not yet available. Try again.
GOTO :mainmenu

:cantusecback
echo C: drive cannot be used as a destination, please select another drive
GOTO :backup

:cantusecmig
echo C: drive cannot be used as a source, please select another drive
GOTO :migration

:invalidletterback
echo A drive with that letter is not connected. Please check the letter and try again.
GOTO :backup

:invalidlettermig
echo A drive with that letter is not connected. Please check the letter and try again.
GOTO :migration

:nobackupfound
echo Backup not found on the selected drive. Please try again.
GOTO :migration

:end
pause
:realend
