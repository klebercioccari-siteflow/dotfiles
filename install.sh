#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔧 Instalando dotfiles..."

# Instala zsh se não existir
if ! command -v zsh &>/dev/null; then
  echo "📦 Instalando zsh..."
  sudo apt-get update -q && sudo apt-get install -y zsh
fi

# Instala Oh My Zsh se não existir
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "📦 Instalando Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Linka os dotfiles
echo "🔗 Linkando arquivos..."
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.zsh_aliases" "$HOME/.zsh_aliases"

# Muda shell padrão para zsh
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "🐚 Mudando shell para zsh..."
  sudo chsh -s "$(which zsh)" "$(whoami)" 2>/dev/null || true
fi

echo "✅ Dotfiles instalados!"