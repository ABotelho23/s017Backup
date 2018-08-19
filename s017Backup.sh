#!/bin/bash

#check OS
if [ `uname` = "Linux" ]
then
  os_check=Linux

elif [ `uname` = "Darwin" ]
then
  os_check=MacOS

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
options=("Backup Users Folder Only (Windows)" "Backup Users Folder Only (MacOS/OSX or GNU/Linux)" "Backup Entire Drive" "Backup Specific Folder" "Quit")
select opt in "${options[@]}"
do
  case $opt in
    "Backup Users Folder Only (Windows)")
      printf "Starting Backup of Windows Users folder..."
      mkdir "/media/StaplesBackup"
      rsync ...
      ;;
    "Backup Users Folder Only (MacOS/OSX or GNU/Linux)")
      if [ $os_check = "MacOS" ]
      then
        printf "Starting Backup of MacOS Users folder..."
        rsync ... MacOS
      elif [ $os_check = "Linux" ]
      then
        printf "Starting Backup of GNU/Linux home folder"
        rsync ... Linux
      else
        printf "Unsure how OS detection was bypassed. Exiting in 5 seconds."
        sleep 5
        exit 1

      fi
      ;;
    "Backup Entire Drive")
      printf "Starting Backup of Selected Drive..."
      rsync /
      rsync ...
      ;;
    "Backup Specific Folder")
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
