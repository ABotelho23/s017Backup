#!/bin/bash

#check OS
if [ `uname` = "Linux" ]
then
  os_check="Linux"

elif [ `uname` = "Darwin" ]
then
  os_check="MacOS"

else
  printf "Sorry, your OS is not supported. Exiting in 5 seconds."
  sleep 5
  exit 1
fi

printf '%s'"----------------------------------------------------------------------\n"
printf "Welcome to Staples Store #17 Tech Backup, Migration and Folder Cloning script!\n"
printf "See https://github.com/ABotelho23/s017Backup for more information\n"
printf "Created by Alex Botelho with the help of Aaron Langlois and Thomas Belway\n"
printf '%s'"----------------------------------------------------------------------\n"

printf "\n========== MAIN MENU ==========\n"
printf "OS: $os_check detected.\n"
PS3='What would you like to do? '
options=("Backup Users/Home Folder Only" "Migrate from an existing backup" "Migrate directly from Windows" "Migrate directly from MacOS" "Quit")
select opt in "${options[@]}"
do
  case $opt in
    "Backup Users/Home Folder Only")
      echo "Backup selected."
      if [ $os_check = "MacOS" ]
      then
        clear
        while [ "$dirExists" != "true" ]; do
          printf "Available drives: \n"
          ls /Volumes
          read -p 'Which volume from the list is the drive to place Backup unto? (Names are case-sensitive!) ' backupDes
          if [ -d "/Volumes/$backupDes" ]; then
          dirExists="true"
          fi
        done
        printf "Starting Backup of MacOS Users folder..."
        mkdir /Volumes/$backupDes
        mkdir /Volumes/$backupDes/StaplesBackup
        mkdir /Volumes/$backupDes/StaplesBackup/Backup
        rsync --verbose --recursive --human-readable --progress -u --log-file="/Volumes/$backupDes/StaplesBackup/backupLog.txt" --exclude=.cache --exclude=.Trash --exclude=.bash_history --exclude=.bash_sessions --exclude=.plist --exclude=Library --exclude=.DS_Store --exclude=Sites --exclude=AirPort.networkConnect --exclude=.CFUserTextEncoding  --exclude=.cups "/Users/" "/Volumes/$backupDes/StaplesBackup/Backup/Users"
      elif [ $os_check = "Linux" ]
      then
        printf "ERROR: LINUX BACKUP NOT AVAILABLE YET."
        #rsync ... Linux
      else
        printf "Unsure how OS detection was bypassed. Exiting in 5 seconds."
        sleep 5
        exit 1
      fi
      break
      ;;

    "Migrate from an existing backup")
      if [ $os_check = "MacOS" ]
      then
        printf "Not available yet."
        #INPUT NAME OF DRIVE TO MIGRATE
      elif [ $os_check = "Linux" ]
      then
        printf "Not available yet."
        #INPUT NAME OF DRIVE TO MIGRATE
      else
        printf "Unsure how OS detection was bypassed. Exiting in 5 seconds."
        sleep 5
        exit 1
      fi
      break
      ;;

    "Migrate directly from Windows")
    echo "Migrate directly from Windows selected."
    if [ $os_check = "MacOS" ]
    then
      clear
      while [ "$dirExists" != "true" ]; do
        printf "Available drives: \n"
        ls /Volumes
        read -p 'Which volume from the list is the Windows drive to migrate? (Names are case-sensitive!) ' migWinSrc
        if [ -d "/Volumes/$migWinSrc" ]; then
        dirExists="true"
        fi
      done
      printf "Starting migration directly from select Windows drive..."
      mkdir /Users/$USER/StaplesMigration
      mkdir /Users/$USER/StaplesMigration/Migration
      rsync --verbose --recursive --human-readable --progress -u --log-file="/Users/$USER/StaplesMigration/directMigrationLog.txt" --exclude="NTUSER.DAT" --exclude="NETUSER.DAT" --exclude="ntuser.dat" --exclude="netuser.dat" --exclude="*.dat.*" --exclude="*.DAT.*" --exclude="All Users" --exclude="AppData" --exclude="Application Data" --exclude="Default User" --exclude="Default" --exclude="DefaultAppPool" --exclude="Default.migrated" --exclude="desktop.ini" "/Volumes/$migWinSrc/Users" "/Users/$USER/StaplesMigration/Migration/Users"
      elif [ $os_check = "Linux" ]
      then
        read -p "What is the mount point of the partition to backup?" inputbackuppartition
        rsync inputbackuppartition
      else
        printf "Unsure how OS detection was bypassed. Exiting in 5 seconds."
        sleep 5
        exit 1
      fi
      break
      ;;
    "Backup Specific Folder")
      read -p 'What is the full path of the folder to backup? ' inputbackupfolder
      printf "Start Backup of Specified Drive..."
      rsync ...
      ;;
    "Quit")
      printf "Quitting..."
      break
      ;;
    *) printf "\nInvalid option: $REPLY \n";;
  esac
done
