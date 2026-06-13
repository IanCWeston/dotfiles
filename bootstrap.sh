#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

DOTFILES_DIR="$HOME/.dotfiles"

print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_info() { echo -e "${YELLOW}→${NC} $1"; }
print_warn() { echo -e "${YELLOW}⚠${NC} $1"; }

is_wsl() {
  grep -qi microsoft /proc/version 2>/dev/null
}

# ---------------------------------------------------------------------------
# OS Detection
# ---------------------------------------------------------------------------
detect_os() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    print_info "Detected OS: $OS"
  else
    print_error "Cannot detect OS"
    exit 1
  fi

  case $OS in
  ubuntu | debian)
    UPDATE_CMD="sudo apt update"
    INSTALL_CMD="sudo apt install -y"
    ;;
  fedora)
    UPDATE_CMD="sudo dnf check-update || true"
    INSTALL_CMD="sudo dnf install -y"
    ;;
  *)
    print_error "Unsupported OS: $OS"
    exit 1
    ;;
  esac
}

# ---------------------------------------------------------------------------
# Base packages — only what mise can't handle
# ---------------------------------------------------------------------------
install_base_packages() {
  print_info "Installing base packages..."
  $UPDATE_CMD

  case $OS in
  ubuntu | debian)
    $INSTALL_CMD git curl zsh tmux build-essential
    ;;
  fedora)
    $INSTALL_CMD git curl zsh tmux @development-tools
    ;;
  esac

  print_success "Base packages installed"
}

# ---------------------------------------------------------------------------
# mise — handles all dev tools from xdg_config/mise/
# ---------------------------------------------------------------------------
install_mise() {
  print_info "Installing mise..."

  if command -v mise &>/dev/null; then
    print_success "mise already installed, skipping"
    return
  fi

  curl https://mise.run | sh
  export PATH="$HOME/.local/bin:$PATH"

  print_success "mise installed"
}

# ---------------------------------------------------------------------------
# mise install — bootstrap all tools from xdg_config/mise/
# ---------------------------------------------------------------------------
mise_install_tools() {
  print_info "Installing mise tools..."

  if ! command -v mise &>/dev/null; then
    print_error "mise not found, skipping tool installation"
    return
  fi

  mise install
  print_success "mise tools installed"
}

# ---------------------------------------------------------------------------
# antidote — zsh plugin manager
# ---------------------------------------------------------------------------
install_antidote() {
  print_info "Installing antidote..."

  ANTIDOTE_DIR="${ZDOTDIR:-$HOME}/.antidote"

  if [ -d "$ANTIDOTE_DIR" ]; then
    print_success "antidote already installed, skipping"
    return
  fi

  git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_DIR"
  print_success "antidote installed"
}

# ---------------------------------------------------------------------------
# TPM — tmux plugin manager
# ---------------------------------------------------------------------------
install_tpm() {
  print_info "Installing TPM..."

  TPM_DIR="$HOME/.tmux/plugins/tpm"

  if [ -d "$TPM_DIR" ]; then
    print_success "TPM already installed, skipping"
    return
  fi

  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  print_success "TPM installed"
}

# ---------------------------------------------------------------------------
# Symlinks
# ---------------------------------------------------------------------------
create_symlinks() {
  print_info "Creating symlinks..."

  # .zshenv at repo root -> ~/.zshenv
  if [ -f "$HOME/.zshenv" ] && [ ! -L "$HOME/.zshenv" ]; then
    print_warn "Skipping .zshenv — real file exists, remove it manually first"
  else
    ln -sf "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
    print_success "Linked .zshenv"
  fi

  # Each subdir in xdg_config/ -> ~/.config/<name>
  mkdir -p "$HOME/.config"
  for dir in "$DOTFILES_DIR/xdg_config"/*/; do
    name=$(basename "$dir")
    target="$HOME/.config/$name"

    if [ "$name" = "wezterm" ] && is_wsl; then
      print_warn "Skipping .config/wezterm (WSL detected — wezterm config belongs on the Windows side at %APPDATA%\\wezterm\\)"
      continue
    fi

    if [ -d "$target" ] && [ ! -L "$target" ]; then
      print_warn "Skipping .config/$name — real directory exists, remove it manually first"
      continue
    fi

    ln -sfn "$dir" "$target"
    print_success "Linked .config/$name"
  done
}

# ---------------------------------------------------------------------------
# Default shell
# ---------------------------------------------------------------------------
change_shell() {
  print_info "Changing default shell to zsh..."

  ZSH_PATH="$(which zsh)"

  # getent is more reliable than $SHELL, which reflects the session not the login shell
  if getent passwd "$USER" | cut -d: -f7 | grep -q "$ZSH_PATH"; then
    print_success "Default shell is already zsh, skipping"
    return
  fi

  chsh -s "$ZSH_PATH"
  print_success "Default shell changed to zsh (takes effect on next login)"
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
  echo ""
  echo "================================"
  echo "  Dotfiles Bootstrap Script"
  echo "================================"
  echo ""

  if [ ! -d "$DOTFILES_DIR" ]; then
    print_error "Dotfiles directory not found at $DOTFILES_DIR"
    print_info "Clone your dotfiles repo first:"
    print_info "  git clone <your-repo-url> $DOTFILES_DIR"
    exit 1
  fi

  detect_os && echo ""
  install_base_packages && echo ""
  install_mise && echo ""
  install_antidote && echo ""
  install_tpm && echo ""
  create_symlinks && echo ""
  mise_install_tools && echo ""
  change_shell && echo ""

  echo "================================"
  print_success "Bootstrap complete!"
  echo "================================"
  echo ""
  echo "Next steps:"
  echo "  1. Log out and back in for the shell change to take effect"
  echo "  2. antidote will install zsh plugins on first zsh launch"
  echo "  3. In tmux, press prefix + I to install tmux plugins"
  if is_wsl; then
    echo ""
    echo "WSL reminders:"
    echo "  - Install your wezterm config on the Windows side at %APPDATA%\\wezterm\\"
    echo "  - Install a Nerd Font on Windows if using oh-my-posh"
  fi
  echo ""
}

main
