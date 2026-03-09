#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔧 Installing dotfiles..."

# install zsh (no sudo, container runs as root)
if ! command -v zsh &>/dev/null; then
  echo "📦 Installing zsh..."
  apk add --no-cache zsh curl
fi

# install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "📦 Installing Oh My Zsh..."
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Extra plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "📦 Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/fast-syntax-highlighting" ]; then
  echo "📦 Installing fast-syntax-highlighting..."
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
fi

if ! command -v fzf &>/dev/null; then
  echo "📦 Installing fzf..."
  apk add --no-cache fzf
fi

# Link dotfiles
echo "🔗 Linking files..."
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.zsh_aliases" "$HOME/.zsh_aliases"

# Set zsh as default shell
ZSH_PATH="$(which zsh)"
if ! grep -q "$ZSH_PATH" /etc/shells; then
  echo "$ZSH_PATH" >> /etc/shells
fi
sed -i "s|root:/bin/sh|root:$ZSH_PATH|g" /etc/passwd
sed -i "s|root:/bin/ash|root:$ZSH_PATH|g" /etc/passwd

echo "✅ Dotfiles installed!"