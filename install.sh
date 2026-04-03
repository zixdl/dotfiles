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

# ---------- Homebrew ----------
if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew already installed."
fi

# Install packages from Brewfile
echo "Installing Homebrew packages..."
brew bundle --file="$DOTFILES/Brewfile"

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
echo "Git user.name set to: $(git config --global user.name)"
echo "Git user.email set to: $(git config --global user.email)"

echo ""
echo "Done setting up git user config!"

echo ""
echo "Done!"
