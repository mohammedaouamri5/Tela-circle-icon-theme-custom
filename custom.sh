#!/usr/bin/env bash
set -euo pipefail

# -------------------------------
# Usage check
# -------------------------------
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <NAME_PACKAGE> <MAIN_COLORS>"
    exit 1
fi

NAME_PACKAGE="$1"
MAIN_COLORS="$2"
ICON_DIR="$HOME/.local/share/icons"

# -------------------------------
# Run the Tela-icon-theme install script
# -------------------------------
./install.sh -n "$NAME_PACKAGE" -d "$ICON_DIR" "$MAIN_COLORS"

# -------------------------------
# Remove old folders if they exist
# -------------------------------
for folder in "$ICON_DIR/${NAME_PACKAGE}" \
              "$ICON_DIR/${NAME_PACKAGE}-light" \
              "$ICON_DIR/${NAME_PACKAGE}-dark"; do
    if [ -d "$folder" ]; then
        rm -rf "$folder"
        echo "Removed old folder: $folder"
    fi
done

# -------------------------------
# Rename installed folders for consistency
# -------------------------------
mv --verbose "$ICON_DIR/${NAME_PACKAGE}-${MAIN_COLORS}" "$ICON_DIR/${NAME_PACKAGE}"
mv --verbose "$ICON_DIR/${NAME_PACKAGE}-${MAIN_COLORS}-light" "$ICON_DIR/${NAME_PACKAGE}-light"
mv --verbose "$ICON_DIR/${NAME_PACKAGE}-${MAIN_COLORS}-dark" "$ICON_DIR/${NAME_PACKAGE}-dark"

echo "Installation complete: $NAME_PACKAGE with colors $MAIN_COLORS"

