#!/bin/bash

#check OS
if [ `uname` = "Linux" ]
then
  os_check="Linux"

elif [ `uname` = "Darwin" ]
then
  os_check="MacOS"

else
  printf "Sorry, there are no plans to support your OS. Exiting in 5 seconds."
  sleep 5
  exit 1
fi

printf '%s'"----------------------------------------------------------------------\n"
printf "Welcome to Staples Store #17 Tech Backup, Migration and Folder Cloning script!\n"
printf "This version of the script is primarily designed for MacOS and Linux. Linux support is coming soon."
printf "See https://github.com/ABotelho23/s017Backup for more information\n"
printf "Created by Alex Botelho with the help of Aaron Langlois and Thomas Belway\n"
printf '%s'"----------------------------------------------------------------------\n"

printf "\n========== MAIN MENU ==========\n"
printf "OS: $os_check detected.\n"
PS3='What would you like to do? '
options=("Backup Users/Home Folder Only" "Migrate From an Existing Backup" "Migrate directly from Windows" "Migrate directly from MacOS" "Quit")
select opt in "${options[@]}"
do
  case $opt in
    "Backup Users/Home Folder Only")
      echo "Backup Users/Home Folder Only selected."
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
        printf "Linux not yet supported."
        sleep 5
        break
      else
        printf "Unsure how OS detection was bypassed. Exiting in 5 seconds."
        sleep 5
        exit 1
      fi
      break
      ;;

    "Migrate From an Existing Backup")
      if [ $os_check = "MacOS" ]
      then
        printf "Not available yet. Work in progress."
        #INPUT NAME OF DRIVE TO MIGRATE
      elif [ $os_check = "Linux" ]
      then
        printf "Linux not yet supported."
        sleep 5
        break
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
      printf "Starting migration directly from selected Windows drive to /Users/$USER/StaplesMigration."
      mkdir /Users/$USER/StaplesMigration
      mkdir /Users/$USER/StaplesMigration/Migration
      rsync --verbose --recursive --human-readable --progress -u --log-file="/Users/$USER/StaplesMigration/directMigrationLog.txt" --exclude="NTUSER.DAT" --exclude="NETUSER.DAT" --exclude="ntuser.dat" --exclude="netuser.dat" --exclude="*.dat.*" --exclude="*.DAT.*" --exclude="All Users" --exclude="AppData" --exclude="Application Data" --exclude="Default User" --exclude="Default" --exclude="DefaultAppPool" --exclude="Default.migrated" --exclude="desktop.ini" "/Volumes/$migWinSrc/Users" "/Users/$USER/StaplesMigration/Migration/Users"
      elif [ $os_check = "Linux" ]
      then
        printf "Linux not yet supported."
        sleep 5
        break
      else
        printf "Unsure how OS detection was bypassed. Exiting in 5 seconds."
        sleep 5
        exit 1
      fi
      break
      ;;
    "Migrate directly from MacOS")
    echo "Migrate directly from MacOS selected."
    if [ $os_check = "MacOS" ]
    then
      clear
      while [ "$dirExists" != "true" ]; do
        printf "Available drives: \n"
        ls /Volumes
        read -p 'Which volume from the list is the MacOS drive to migrate? (Names are case-sensitive!) ' migMacSrc
        if [ -d "/Volumes/$migMacSrc" ]; then
        dirExists="true"
        fi
      done
      printf "Starting migration directly from select MacOS drive to /Users/$USER/StaplesMigration"
      mkdir /Users/$USER/StaplesMigration
      mkdir /Users/$USER/StaplesMigration/Migration
      rsync --verbose --recursive --human-readable --progress -u --log-file="/Users/$USER/StaplesMigration/directMigrationLog.txt" --exclude=.cache --exclude=.Trash --exclude=.bash_history --exclude=.bash_sessions --exclude=.plist --exclude=Library --exclude=.DS_Store --exclude=Sites --exclude=AirPort.networkConnect --exclude=.CFUserTextEncoding  --exclude=.cups "/Volumes/$migMacSrc/Users" "/Users/$USER/StaplesMigration/Migration/Users"
      elif [ $os_check = "Linux" ]
      then
        printf "Linux not yet supported."
        sleep 5
        break
      else
        printf "Unsure how OS detection was bypassed. Exiting in 5 seconds."
        sleep 5
        exit 1
      fi
      break
      ;;
    "Quit")
      printf "Quitting..."
      break
      ;;
    *) printf "\nInvalid option: $REPLY \n";;
  esac
done
