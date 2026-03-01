#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "📦 Installing dotfiles from: $DOTFILES_DIR"
mkdir -p "$CONFIG_DIR"

for dir in "$DOTFILES_DIR"/*/; do
    name="$(basename "$dir")"
    target="$CONFIG_DIR/$name"

    # skip .git or hidden dirs
    [[ "$name" == .* ]] && continue

    echo "→ Processing $name"

    if [ -L "$target" ]; then
        echo "   Already symlinked, skipping"
        continue
    fi

    if [ -e "$target" ]; then
        echo "   Backing up existing config"
        mv "$target" "$target.backup.$(date +%s)"
    fi

    ln -s "$dir" "$target"
    echo "   Symlink created"
done

echo "✅ Done"