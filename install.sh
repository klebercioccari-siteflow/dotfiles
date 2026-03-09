#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔧 Installing dotfiles..."

# install zsh if not installed
if ! command -v zsh &>/dev/null; then
  echo "📦 Installing zsh..."
  sudo apt-get update -q && sudo apt-get install -y zsh
fi

# install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "📦 Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Link the dotfiles
echo "🔗 Linking files..."
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.zsh_aliases" "$HOME/.zsh_aliases"

# Change default shell to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "🐚 Changing shell to zsh..."
  sudo chsh -s "$(which zsh)" "$(whoami)" 2>/dev/null || true
fi

echo "✅ Dotfiles installed!"