#!/bin/bash
set -e

# Folders to merge from backup
FOLDERS=("_layouts" "_includes" "_sass" "assets")

# Backup folder (where your previous customizations were saved)
BACKUP_FOLDER="./backup_theme"

# Check if backup exists
if [ ! -d "$BACKUP_FOLDER" ]; then
  echo "Backup folder $BACKUP_FOLDER does not exist. Exiting."
  exit 1
fi

echo "Restoring customizations from $BACKUP_FOLDER..."

for folder in "${FOLDERS[@]}"; do
  if [ -d "$BACKUP_FOLDER/$folder" ]; then
    echo "Merging $folder..."
    mkdir -p "./$folder"
    # Copy all files from backup, preserving theme files and overwriting only your custom files
    rsync -av --ignore-existing "$BACKUP_FOLDER/$folder/" "./$folder/"
  else
    echo "No backup found for $folder, skipping..."
  fi
done

echo "Merge complete. Your customizations are restored while keeping theme fixes."
