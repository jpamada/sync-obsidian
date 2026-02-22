#!/usr/bin/env bash

OS=""
OS_WIN="/c/Windows"
OS_ARCH="/etc/pacman.d"
OS_ANDROID="/system/build.prop"

OBSIDIAN_PATH=""
CURRENT_TIME=$(date "+%m-%d-%Y %H:%M:%S")
GIT_ACTION="$1"
USER=$(whoami)

if [ -d "$OS_WIN" ]; then
   echo "This OS is Windows."
   OS="WIN"
   OBSIDIAN_PATH="/c/Users/$USER/Personal/Second Brain"
elif [ -d "$OS_ARCH" ]; then
   echo "This OS is Archlinux."
   OS="ARCH"
   OBSIDIAN_PATH="/home/$USER/Personal/Obsidian/second-brain/"
elif [ -f "$OS_ANDROID" ]; then
   echo "This OS is Android."
   OS="ANDR"
   OBSIDIAN_PATH="$HOME/storage/shared/Personal/Obsidian/second-brain/"
else
   echo "This OS is not compatible."
   exit 1;
fi

cd "$OBSIDIAN_PATH"

# OBSIDIAN PATH VALIDATION
if [ -d "$OBSIDIAN_PATH" ]; then
    echo "Success: Obsidian path found, proceeding..."
else
    echo "Error: Obsidian path not found."
    exit 1
fi

# GIT ACTIONS
if [ "$GIT_ACTION" = "save" ]; then
    git add .
    git commit -m "($OS) $CURRENT_TIME"
    git push -u origin main
    echo "Success: Obsidian Vault successfuly saved."
elif [ "$GIT_ACTION" = "sync" ]; then
    git pull --rebase origin main
    echo "Success: Obsidian Vault successfuly synced."
else
    echo "Error: Invalid git action."
    exit 1
fi
