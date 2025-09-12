#!/bin/bash

# Script to vendor jekyll-dash theme safely

# Path to installed jekyll-dash gem
THEME_PATH=$(bundle show jekyll-dash)

# Folders to backup and copy
FOLDERS=("_layouts" "_includes" "_sass" "assets")

echo "Backing up existing folders..."
for folder in "${FOLDERS[@]}"; do
  if [ -d "$folder" ]; then
    BACKUP_NAME="${folder}_backup_$(date +%Y%m%d%H%M%S)"
    echo "Backing up $folder -> $BACKUP_NAME"
    mv "$folder" "$BACKUP_NAME"
  fi
done

echo "Copying theme files from $THEME_PATH ..."
for folder in "${FOLDERS[@]}"; do
  SRC="$THEME_PATH/$folder"
  if [ -d "$SRC" ]; then
    echo "Copying $folder"
    cp -r "$SRC" ./
  fi
done

echo "Done! Existing folders are backed up, and theme files are copied."
echo "You can now remove 'theme: jekyll-dash' from _config.yml and test locally."
