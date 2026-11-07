#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$HOME/.config"

touch "./hypr/hyprland/user.lua"

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

# Symlink wallpaper
if [ -f "$DOTFILES_DIR/wallpaper.png" ]; then
    ln -sfn "$DOTFILES_DIR/wallpaper.png" "$HOME/wallpaper.png"
    echo "🖼️  Wallpaper symlinked to ~/wallpaper.png"
fi

# Symlink starship config
if [ -f "$DOTFILES_DIR/starship.toml" ]; then
    if [ -e "$CONFIG_DIR/starship.toml" ] && [ ! -L "$CONFIG_DIR/starship.toml" ]; then
        mv "$CONFIG_DIR/starship.toml" "$CONFIG_DIR/starship.toml.backup.$(date +%s)"
    fi
    ln -sfn "$DOTFILES_DIR/starship.toml" "$CONFIG_DIR/starship.toml"
    echo "🚀 Starship config symlinked"
fi

echo "✅ Done"