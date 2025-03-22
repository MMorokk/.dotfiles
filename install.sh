#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Make sure the config directory exists
mkdir -p "$HOME/.config"

# Find all files and directories in the script directory (excluding the script itself)
SCRIPT_NAME=$(basename "$0")
for item in "$SCRIPT_DIR"/*; do
    # Skip the script itself
    if [ "$(basename "$item")" = "$SCRIPT_NAME" ]; then
        continue
    fi

    # Get just the basename of the item
    base_name=$(basename "$item")

    # Check if a symlink or file already exists in the destination
    if [ -e "$HOME/.config/$base_name" ] || [ -L "$HOME/.config/$base_name" ]; then
        echo "WARNING: '$HOME/.config/$base_name' already exists, skipping..."
    else
        # Create the symbolic link
        ln -s "$item" "$HOME/.config/$base_name"
        echo "Created symlink for '$base_name'"
    fi
done

echo "Finished creating symlinks to $HOME/.config"
