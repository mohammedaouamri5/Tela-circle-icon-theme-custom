#!/usr/bin/env bash
set -euo pipefail

# -------------------------------
# Usage check
# -------------------------------
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <NAME_PACKAGE> <MAIN_COLORS> [--circle]"
    exit 1
fi

NAME_PACKAGE="$1"
MAIN_COLORS="$2"
CIRCLE=false

# Check optional third argument
if [ "${3:-}" == "--circle" ]; then
    CIRCLE=true
fi

ICON_DIR="$HOME/.local/share/icons"

# -------------------------------
# Run the Tela-icon-theme install script
# -------------------------------


if [ "$CIRCLE" = true ]; then
    ./install.sh -c -n "$NAME_PACKAGE" -d "$ICON_DIR" "$MAIN_COLORS"
fi

if [ "$CIRCLE" = false ]; then
    ./install.sh -n "$NAME_PACKAGE" -d "$ICON_DIR" "$MAIN_COLORS"
fi


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

# -------------------------------
# Optional: handle circle variant
# -------------------------------
if [ "$CIRCLE" = true ]; then
    echo "Adding circle variant..."
    # Example: rename dark variant to a circle variant
    if [ -d "$ICON_DIR/${NAME_PACKAGE}-dark" ]; then
        cp -r "$ICON_DIR/${NAME_PACKAGE}-dark" "$ICON_DIR/${NAME_PACKAGE}-circle"
        echo "Circle variant created at $ICON_DIR/${NAME_PACKAGE}-circle"
    fi
fi

echo "Installation complete: $NAME_PACKAGE with colors $MAIN_COLORS"

