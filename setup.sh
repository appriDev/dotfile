#!/usr/bin/env bash
set -e

echo "🚀 Bootstrapping system..."

DOTFILES_DIR="$HOME/dotfiles"

# -----------------------------
# Packages
# -----------------------------
sudo apt update
sudo apt install -y \
  zsh tmux neovim git curl unzip \
  fzf ripgrep ca-certificates

# -----------------------------
# oh-my-posh
# -----------------------------
if ! command -v oh-my-posh >/dev/null; then
  echo "✨ Installing oh-my-posh..."
  curl -s https://ohmyposh.dev/install.sh | sudo bash
fi

# -----------------------------
# Symlinks (XDG compliant)
# -----------------------------
echo "🔗 Linking configs..."

mkdir -p "$HOME/.config"

ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/nvim/nvim" "$HOME/.config/nvim"
ln -sf "$DOTFILES_DIR/tmux/tmux" "$HOME/.config/tmux"
ln -sf "$DOTFILES_DIR/ohmyposh" "$HOME/.config/ohmyposh"

# -----------------------------
# Fonts
# -----------------------------
echo "🔤 Installing fonts..."
mkdir -p "$HOME/.local/share/fonts"
cp -r "$DOTFILES_DIR/fonts/"* "$HOME/.local/share/fonts/" 2>/dev/null || true
fc-cache -fv

# -----------------------------
# Neovim plugins (non-blocking)
# -----------------------------
nvim --headless "+Lazy sync" +qa 2>/dev/null || true

# -----------------------------
# tmux TPM (optional but common)
# -----------------------------
if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm \
    "$HOME/.config/tmux/plugins/tpm"
fi

# -----------------------------
# Default shell
# -----------------------------
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "🐚 Setting zsh as default shell..."
  chsh -s "$(which zsh)"
fi

echo "✅ All done!"
echo "➡️ Log out and log back in."

