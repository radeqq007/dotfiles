#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Error: No image file provided."
    echo "Usage: $0 /path/to/image.jpg"
    exit 1
fi

IMAGE_PATH=$(realpath "$1" 2>/dev/null)

if [ ! -f "$IMAGE_PATH" ]; then
    echo "Error: File '$1' does not exist."
    exit 1
fi

echo ":: Changing wallpaper to: $IMAGE_PATH"

if ! pgrep -x "hyprpaper" > /dev/null; then
    hyprpaper &
    sleep 0.5
fi

hyprctl hyprpaper wallpaper ",$IMAGE_PATH"

matugen image "$IMAGE_PATH"

~/.config/scripts/reload-waybar.sh

