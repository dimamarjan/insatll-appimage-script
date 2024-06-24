#!/bin/bash

if [[ $# -lt 2 || $# -gt 3 ]]; then
    echo "Usage: $0 <path_to_appimage_or_exe> <path_to_icon> [name]"
    exit 1
fi

APP_FILE="$1"
ICON_FILE="$2"
APP_NAME="${3:-$(basename "$APP_FILE" .AppImage)}"
APP_NAME="${APP_NAME%%.exe}"
ICON_EXT="${ICON_FILE##*.}"

if [[ ! -f "$APP_FILE" ]]; then
    echo "Application file not found: $APP_FILE"
    exit 1
fi

if [[ ! -f "$ICON_FILE" ]]; then
    echo "Icon file not found: $ICON_FILE"
    exit 1
fi

SYMLINK="/usr/local/bin/$APP_NAME"

ICON_DIR="/usr/share/icons/hicolor/512x512/apps"
sudo mkdir -p "$ICON_DIR"

ICON_DEST="$ICON_DIR/$APP_NAME.png"
sudo cp "$ICON_FILE" "$ICON_DEST"

sudo ln -sf "$(realpath "$APP_FILE")" "$SYMLINK"
echo "Symbolic link updated: $SYMLINK -> $APP_FILE"

DESKTOP_FILE_PATH="$HOME/.local/share/applications/$APP_NAME.desktop"
EXEC_CMD="$SYMLINK --no-sandbox %U"
if [[ "$APP_FILE" == *.exe ]]; then
    EXEC_CMD="wine $SYMLINK"
fi

echo "[Desktop Entry]
Name=$APP_NAME
Exec=$EXEC_CMD
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
