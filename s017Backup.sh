#!/bin/bash
printf '%s'"----------------------------------------------------------------------\n"
printf "Welcome to Staples Store #17 Tech Backup, Migration and Folder Cloning script!\n"
printf "See https://github.com/ABotelho23/s017Backup for more information\n"
printf "Created by Alex Botelho with the help of Aaron Langlois and Thomas Belway\n"
printf '%s'"----------------------------------------------------------------------\n"

printf "\n========== MAIN MENU ==========\n"

PS3='What would you like to do? '
options=("Backup Users Folder Only (Windows)" "Backup Users Folder Only (MacOS/OSX)" "Backup Users Folder Only (Linux/GNU)" "Backup Entire Drive" "Backup Specific Folder" "Quit")
select opt in "${options[@]}"
do
  case $opt in
    "Backup Users Folder Only (Windows)")
      printf "Starting Backup of Windows Users folder..."
      ;;
    "Backup Users Folder Only (MacOS/OSX)")
      printf "Starting Backup of MacOS Users folder..."
      ;;
    "Backup Users Folder Only (Linux/GNU)")
      printf "Starting Backup of Linux/GNU home folder..."
      ;;
    "Backup Entire Drive")
      printf "Starting Backup of Selected Drive..."
      ;;
    "Backup Specific Folder")
      printf "Start Backup of Specified Drive..."
      ;;
    "Quit")
      break
      ;;
    *) printf "\nInvalid option: $REPLY \n";;
  esac
done
