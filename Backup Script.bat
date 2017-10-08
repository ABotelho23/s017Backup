echo off
echo Welcome to Staples Tech Backup and Migrate script
echo What would you like to do?
echo 1. Backup data
echo 2. Migrate data
robocopy "C:\Users" "E:\Staples Backup\Users" /v /log:"E:\backupLog.txt" /e /zb /mt:4 /r:3 /w:3 /copy:dt /tee /eta /xj /xf "NETUSER.DAT" /xd "Local Settings" /xd "AppData" /xd "Application Data" /xd "E:\Users\All Users" /xd "E:\Default User" /xd "E:\Users\Default" /xd "E:\Users\DefaultAppPool" /xd "E:\Users\Default.migrated"
echo "BACKUP COMPLETE. Displaying log file.
start "" "E:\backupLog.txt"
