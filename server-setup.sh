#!/usr/bin/env bash
set -e

echo "🚀 Bootstrapping Ubuntu Server environment..."

DOTFILES_DIR="$HOME/dotfiles"

# -----------------------------
# Packages
# -----------------------------
echo "📦 Installing packages..."
sudo apt update
sudo apt install -y \
  zsh tmux neovim git curl unzip fzf ripgrep build-essential

# -----------------------------
# oh-my-posh
# -----------------------------
if ! command -v oh-my-posh >/dev/null; then
  echo "✨ Installing oh-my-posh..."
  curl -s https://ohmyposh.dev/install.sh | sudo bash
fi

# -----------------------------
# Zinit
# -----------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# -----------------------------
# Dotfiles (configs)
# -----------------------------
echo "🔗 Linking configs..."
mkdir -p "$HOME/.config"

# zshrc
ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

# tmux
ln -sf "$DOTFILES_DIR/tmux/tmux" "$HOME/.config/tmux"

# nvim
ln -sf "$DOTFILES_DIR/nvim/nvim" "$HOME/.config/nvim"

# oh-my-posh
ln -sf "$DOTFILES_DIR/ohmyposh" "$HOME/.config/ohmyposh"

# -----------------------------
# Fonts (optional on server, skipped)
# -----------------------------
# Server usually doesn't need Nerd Fonts

# -----------------------------
# NVM
# -----------------------------
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
    mkdir -p "$NVM_DIR"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# -----------------------------
# pyenv
# -----------------------------
if [ ! -d "$HOME/.pyenv" ]; then
    curl https://pyenv.run | bash
fi

# -----------------------------
# tmux TPM
# -----------------------------
if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm \
        "$HOME/.config/tmux/plugins/tpm"
fi

# -----------------------------
# Neovim plugins (headless)
# -----------------------------
nvim --headless "+Lazy sync" +qa 2>/dev/null || true

# -----------------------------
# Default shell
# -----------------------------
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🐚 Setting zsh as default shell..."
    chsh -s "$(which zsh)"
fi

echo "✅ Ubuntu Server setup complete!"
echo "➡️ Log out and log back in, then open a new terminal."

