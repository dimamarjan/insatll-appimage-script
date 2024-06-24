#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <path_to_appimage> <path_to_icon>"
    exit 1
fi

APPIMAGE_FILE="$1"
ICON_FILE="$2"

if [[ ! -f "$APPIMAGE_FILE" ]]; then
    echo "AppImage file not found: $APPIMAGE_FILE"
    exit 1
fi

if [[ ! -f "$ICON_FILE" ]]; then
    echo "Icon file not found: $ICON_FILE"
    exit 1
fi

APP_NAME=$(basename "$APPIMAGE_FILE" .AppImage)

SYMLINK="/usr/local/bin/$APP_NAME.appimage"

ICON_DIR="/usr/share/icons/hicolor/512x512/apps"
sudo mkdir -p "$ICON_DIR"

ICON_DEST="$ICON_DIR/$APP_NAME.png"
sudo cp "$ICON_FILE" "$ICON_DEST"

sudo ln -sf "$APPIMAGE_FILE" "$SYMLINK"
echo "Symbolic link updated: $SYMLINK -> $APPIMAGE_FILE"

DESKTOP_FILE_PATH="$HOME/.local/share/applications/$APP_NAME.desktop"
echo "[Desktop Entry]
Name=$APP_NAME
Exec=$SYMLINK
Terminal=false
Type=Application
Icon=$APP_NAME
StartupWMClass=$APP_NAME
Comment=$APP_NAME is an application.
Categories=Utility;" > "$DESKTOP_FILE_PATH"

chmod 644 "$DESKTOP_FILE_PATH"
echo "Desktop file created: $DESKTOP_FILE_PATH"

update-desktop-database "$HOME/.local/share/applications"
echo "Desktop database updated."
