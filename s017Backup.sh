#!/bin/bash
printf '%s'"----------------------------------------------------------------------\n"
printf "Welcome to Staples Store #17 Tech Backup, Migration and Folder Cloning script!\n"
printf "See https://github.com/ABotelho23/s017Backup for more information\n"
printf "Created by Alex Botelho with the help of Aaron Langlois and Thomas Belway\n"
printf '%s'"----------------------------------------------------------------------\n"

PS3='MAIN MENU'
options=("1. Backup Users Folder Only (Windows)" "2. Backup Users Folder Only (MacOS/OSX)" "3. Backup Entire Drive" "4. Backup Specific Folder" "Quit")
select opt in "${options[@]}"
do
  case $opt in
    "Backup Users Folder Only (Windows)")
      printf "Starting Backup of Windows Users folder..."
      ;;
    "2. Backup Users Folder Only (MacOS/OSX)")
      printf "Starting Backup of MacOS Users folder..."
      ;;
    "3. Backup Entire Drive")
      printf "Starting Backup of Selected Drive..."
      ;;
    "4. Backup Specific Folder")
      printf "Start Backup of Specified Drive..."
      ;;
    "Quit")
      break
      ;;
    *) printf "Invalid option $REPLY";;
  esac
done
