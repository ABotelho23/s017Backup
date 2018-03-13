# s017Backup
## Unofficial Staples Canada Store #17 Windows Backup and Migration script

This is an unofficial backup script designed from scratch for use in the Staples store #17. It creates a backup of User folders in Windows Vista-Windows 10, in a standard format. It also logs the backup (and any migrations) to ensure they have completed successfully. It primarily uses robocopy copy to perform the backup, with particular exclusions and parameters to ensure the optimal performance of the script.

I started this because of a lack of proper tools to perform this task that are available as the workplace. Copy and pasting via File Explorer was both slow, needed constant intervention, and usually doesn't succeed 100%.

I've made this script open source as it may be of good use to other techs, as well as to hopefully increase collaboration on best practices for a script like this.

Available options:

**1. Backup Data**  - *Used for standard User folders backup when unit can boot.*

-This option is the base option for this script. A folder called "StaplesBackup" is created in the root directory of the selected drive, which contains the backup as well as the log file of the machine on which it is run.

**2. Migrate Data** - *Used to migrate a User folders backup created by this script back unto the newly setup unit's User folders.*

-This option is the secondary option for this script. It seeks a "StaplesBackup" folder on the selected drive, and migrates the backup directly to the User folders of the machine on which it is run. Thus, if the old user folder and new user folder are not named the same, data may not be moved to the correct folder.

**3. Migrate Directly from an Old PC's HDD** - *Used for when the old PC does not boot, and its HDD is docked to the new PC.*

-This option is a hybrid of Backup and Migration. It is for scenarios where an old PC's HDD it connected to a new PC being setup, and allows the bypassing of a backup. Similar to the Migration option, if the old user folder and new user folder are not named the same, data may not be moved to the correct folder.

**4. Clone folders** - *Simply clones the contents of two folders. Do NOT use to migrate User folders; this option does not have exclusions for files not meant to be migrated.*

-This option is intended to clone two folders, regardless of where they may be. Its intended purpose is to move data which is not present in the User folders.

**5. Backup Data (CUSTOM)** - *Used for backing up a PC's User folders when the PC doesn't boot. An external HDD is also required for this option.*

-This option is the least likely. To be used when the HDD that is being backed up is not in a bootable state. Its intended purpose is to backup a PC's HDD using a second PC to perform the work.
