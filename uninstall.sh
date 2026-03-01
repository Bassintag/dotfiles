#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "🗑️ Removing dotfile symlinks"

for dir in "$DOTFILES_DIR"/*/; do
    name="$(basename "$dir")"
    target="$CONFIG_DIR/$name"

    [[ "$name" == .* ]] && continue

    if [ -L "$target" ]; then
        link_target="$(readlink "$target")"

        if [[ "$link_target" == "$DOTFILES_DIR"* ]]; then
            rm "$target"
            echo "→ Removed $name"
        fi
    fi
done

echo "✅ Uninstall complete"