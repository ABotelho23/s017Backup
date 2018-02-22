@echo off
openfiles > NUL 2>&1
if NOT %ERRORLEVEL% EQU 0 goto :NotAdmin
echo Welcome to Staples Store #17 Tech Backup and Migrate script!
goto :mainmenu
:NotAdmin
echo PLEASE RUN AS ADMIN. Closing in 10 seconds.
TIMEOUT 10
GOTO :realend

:mainmenu
echo ----------
echo ----------
echo MAIN MENU - What would you like to do?
echo 1. Backup Data
echo 2. Migrate Data [experimental/testing]
echo 3. Migrate Directly from an Old PC's HDD [experimental/testing]
echo 4. Migrate Data (Custom) [COMING SOON]
set /P backMigSel=What would you like to do?

IF "%backMigSel%"=="1" GOTO :backup
IF "%backMigSel%"=="2" GOTO :migration
IF "%backMigSel%"=="3" GOTO :migrateoldpc
IF "%backMigSel%"=="4" GOTO :migrationcustom

echo That is not a valid selection, returning to main menu.
GOTO :mainmenu

:backup
set /P backDestLet=What is the drive letter of the drive to put the backup unto?
IF "%backDestLet%"=="c" GOTO :cantusecback
IF "%backDestLet%"=="C" GOTO :cantusecback
IF NOT EXIST "%backDestLet%:\" GOTO :invalidletterback

echo Valid selection. Starting Backup in 3 seconds.
TIMEOUT 3
echo STARTING BACKUP from C:\Users to "%backDestLet%:\StaplesBackup\Users".

mkdir "%backDestLet%:\StaplesBackup"
mkdir "%backDestLet%:\StaplesBackup\Backup"
mkdir "%backDestLet%:\StaplesBackup\Backup\Users"
robocopy "C:\Users" "%backDestLet%:\StaplesBackup\Backup\Users" /v /log:"%backDestLet%:\StaplesBackup\backupLog.txt" /e /zb /mt:4 /r:3 /w:3 /copy:dt /tee /eta /xj /xf "NETUSER.DAT" /xf "NETUSER.DAT*" /xf "netuser.dat.*" /xd "Local Settings" /xd "AppData" /xd "Application Data" /xd "C:\Users\All Users" /xd "C:\Default User" /xd "C:\Users\Default" /xd "C:\Users\DefaultAppPool" /xd "C:\Users\Default.migrated"
echo BACKUP COMPLETE. Please verify. Displaying log file.
start "" "%backDestLet%:\StaplesBackup\backupLog.txt"
GOTO :end

:migration
set /P migSrcLet=What is the drive letter of the drive to migrate from?
IF "%migSrcLet%"=="c" GOTO :cantusecmig
IF "%migSrcLet%"=="C" GOTO :cantusecmig
IF NOT EXIST "%migSrcLet%:\" GOTO :invalidlettermig
IF NOT EXIST "%migSrcLet%:\StaplesBackup" GOTO :nobackupfound

echo Valid selection. Starting Migration in 3 seconds.
echo Note: Migration is done to Users folder; if old user folder name is different from new user old, unexpected results may occur.
TIMEOUT 3
echo STARTING MIGRATION from "%migSrcLet%:\StaplesBackup\Backup\Users" to "C:\Users".

robocopy "%migSrcLet%:\StaplesBackup\Backup\Users" "C:\Users" /v /log:"C:\Users\migrationLog.txt" /e /zb /mt:4 /r:3 /w:3 /copy:dt /tee /eta
echo MIGRATION COMPLETE. Displaying log file.
start "" "C:\Users\migrationLog.txt"
GOTO :end

:migrateoldpc
set /P oldSrcLet=What is the drive letter of the old drive connected as?
IF "%oldSrcLet%"=="c" GOTO :cantusecold
IF "%oldSrcLet%"=="C" GOTO :cantusecold
IF NOT EXIST "%oldSrcLet%:\" GOTO :invalidletterold
IF NOT EXIST "%oldSrcLet%:\Users" GOTO :notoldhdd

echo Valid selection. Starting Migration from old PC in 3 seconds.
TIMEOUT 3
echo STARTING MIGRATION FROM OLD PC "%oldSrcLet%:\Users" to "C:\Users".

robocopy "%oldSrcLet%:\Users" "C:\Users" /v /log:"C:\Users\migrationLog.txt" /e /zb /mt:4 /r:3 /w:3 /copy:dt /tee /eta /xj /xf "NETUSER.DAT" /xf "NETUSER.DAT*" /xf "netuser.dat.*" /xd "Local Settings" /xd "AppData" /xd "Application Data" /xd "%oldSrcLet%:\Users\All Users" /xd "%oldSrcLet%:\Default User" /xd "%oldSrcLet%:\Users\Default" /xd "%oldSrcLet%:\Users\DefaultAppPool" /xd "%oldSrcLet%:\Users\Default.migrated"
echo MIGRATION FROM OLD PC COMPLETE. Please verify. Displaying log file.
start "" "C:\Users\migrationLog.txt"
GOTO :end

:migrationcustom
echo Custom migrations not yet available. Please try again.
GOTO :mainmenu

:cantusecback
echo C: drive cannot be used as a destination, please select another drive
GOTO :backup

:invalidletterback
echo A drive with that letter is not connected. Please check the letter and try again.
GOTO :backup

:cantusecmig
echo C: drive cannot be used as a source, please select another drive
GOTO :migration

:invalidlettermig
echo A drive with that letter is not connected. Please check the letter and try again.
GOTO :migration

:nobackupfound
echo Staples-made backup not found on the selected drive. Please try again.
GOTO :migration

:cantusecold
echo C: drive cannot be used as a source, please select another drive
GOTO :migrateoldpc

:invalidletterold
echo A drive with that letter is not connected. Please check the letter and try again.
GOTO :migrateoldpc

:nobackupfound
echo This drive doesn't look like an old PC's drive. Please try again.
GOTO :migration

:end
pause
:realend
