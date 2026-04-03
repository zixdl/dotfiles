#!/bin/bash

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# ---------- Helper ----------
link() {
    local src="$1"
    local dest="$2"

    # Create parent directory if needed
    mkdir -p "$(dirname "$dest")"

    # Remove existing file/symlink
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        rm "$dest"
        echo "Removed existing $dest"
    fi

    # Create symlink
    ln -s "$src" "$dest"
    echo "Linked $dest → $src"
}

# ---------- Git ----------
link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILES/git/.gitignore_global" "$HOME/.gitignore_global"

# ---------- Zsh ----------
# Uncomment these when ready:
# link "$DOTFILES/zsh/.zshrc"     "$HOME/.zshrc"
# link "$DOTFILES/zsh/.zprofile"  "$HOME/.zprofile"

# ---------- SSH ----------
# Uncomment when ready:
# link "$DOTFILES/ssh/config"     "$HOME/.ssh/config"

# ---------- Git user config ----------
echo ""
echo "Setting up git user config..."
echo "This will be used for your git commits."
read -p "Enter your git name: " git_user_name
read -p "Enter your git email: " git_user_email
git config --global user.name "$git_user_name"
git config --global user.email "$git_user_email"

echo ""
echo "Done!"
