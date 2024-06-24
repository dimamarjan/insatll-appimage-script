#!/bin/bash

if [[ $# -lt 2 || $# -gt 3 ]]; then
    echo "Usage: $0 <path_to_appimage> <path_to_icon> [name]"
    exit 1
fi

APPIMAGE_FILE="$1"
ICON_FILE="$2"
APP_NAME="${3:-$(basename "$APPIMAGE_FILE" .AppImage)}"
ICON_EXT="${ICON_FILE##*.}"

if [[ ! -f "$APPIMAGE_FILE" ]]; then
    echo "AppImage file not found: $APPIMAGE_FILE"
    exit 1
fi

if [[ ! -f "$ICON_FILE" ]]; then
    echo "Icon file not found: $ICON_FILE"
    exit 1
fi

SYMLINK="/usr/local/bin/$APP_NAME.appimage"

ICON_DIR="/usr/share/icons/hicolor/512x512/apps"
sudo mkdir -p "$ICON_DIR"

ICON_DEST="$ICON_DIR/$APP_NAME.png"
sudo cp "$ICON_FILE" "$ICON_DEST"

sudo ln -sf "$(realpath "$APPIMAGE_FILE")" "$SYMLINK"
echo "Symbolic link updated: $SYMLINK -> $APPIMAGE_FILE"

DESKTOP_FILE_PATH="$HOME/.local/share/applications/$APP_NAME.desktop"
echo "[Desktop Entry]
Name=$APP_NAME
Exec=$SYMLINK --no-sandbox %U
Terminal=false
Type=Application
Icon=$ICON_DIR/$APP_NAME.$ICON_EXT
StartupWMClass=$APP_NAME
Comment=$APP_NAME is an application.
Categories=Utility;" > "$DESKTOP_FILE_PATH"

chmod 644 "$DESKTOP_FILE_PATH"
echo "Desktop file created: $DESKTOP_FILE_PATH"

update-desktop-database "$HOME/.local/share/applications"
echo "Desktop database updated."

