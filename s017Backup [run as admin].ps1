#
# s017Backup - Unofficial Staples Canada Store #17 Windows Backup and Migration script
#
# This is an unofficial backup script designed from scratch for use in the Staples store #17.
# It creates a backup of User folders from Windows Vista right up to Windows 10, in a standard format.
# It also logs the backup (and any migrations) to ensure they have completed successfully.
# It primarily uses robocopy to perform the backup, with particular exclusions and parameters to ensure the optimal performance of the script.
#

function Show-Menu
{
    param (
        [string]$Title = 'Main Menu'
    )
    cls
    Write-Host "================ $Title ================"

    Write-Host "1: Backup Data"
    Write-Host "2: Migrate Data [experimental]"
    Write-Host "3: Migrate Directly from an Old PC's HDD [experimental]"
    Write-Host "4: Backup Data (CUSTOM) [experimental]"
    Write-Host "5: Clone folders [experimental]"
    Write-Host "Q: Press 'Q' to quit."
}

function PerfBackup
{
    param ($srcFolder, $dstFolder,$roboArgsYOrN,$jobType,$logLocation)
    cls
    Write-Host "Starting $jobType from $srcFolder to $dstFolder"
    robocopy "$srcFolder" "$dstFolder" /v /log+:"$logLocation\$jobTypeLogLog.txt" /e /zb /mt:4 /r:3 /w:5 /copy:dt /tee /eta /xj /xf "NETUSER.DAT" /xf "NETUSER.DAT*" /xf "netuser.dat.*" /xd "Local Settings" /xd "AppData" /xd "Application Data" /xd "C:\Users\All Users" /xd "C:\Default User" /xd "C:\Users\Default" /xd "C:\Users\DefaultAppPool" /xd "C:\Users\Default.migrated"

}

do
{
    Show-Menu
    $input = Read-Host "What would you like to do?"
    switch ($input)
    {
        '1' {
            cls
            'You chose option #1'
            $backDstLet = Read-Host "What is the drive letter of the drive to put the backup unto?"
            $date = Get-Date
            $date = $date.ToString("yyyy-MM-dd")
            New-Item -ItemType directory -Path "$backDstLet:\StaplesBackup-$date"
            PerfBackup "C:\Users" "$backDstLet:\StaplesBackup-$date\Backup\Users" "yes" "backup" "$backDstLet:\StaplesBackup-$date"

        } '2' {
            cls
            'You chose option #2'
        } '3' {
            cls
            'You chose option #3'
        } '4' {
            cls
            'You chose option #4'
        } '5' {
            cls
            'You chose option #5'
        } 'q' {
            return
            }
    }
    #stuff here
}
until ($input -eq 'q')
