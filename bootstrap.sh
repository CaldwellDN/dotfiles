#!/usr/bin/env bash

set -e

REPO="git@github.com:CaldwellDN/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"
WORK_TREE="$HOME"
ALIAS_NAME="dotfiles"

# Define the dotfiles function so it's usable within the script
dotfiles() {
  /usr/bin/git --git-dir="$DOTFILES_DIR" --work-tree="$WORK_TREE" "$@"
}
export -f dotfiles

echo "[*] Cloning dotfiles bare repo into $DOTFILES_DIR..."
git clone --bare "$REPO" "$DOTFILES_DIR"

echo "[*] Setting up alias for dotfiles..."
# Adding dotfiles function to the current shell session
echo "alias $ALIAS_NAME='/usr/bin/git --git-dir=$DOTFILES_DIR --work-tree=$WORK_TREE'" >> "$HOME/.bashrc"

echo "[*] Backing up any pre-existing dotfiles..."
mkdir -p "$WORK_TREE/.dotfiles-backup"
dotfiles checkout || {
  echo "[!] Detected conflicting files. Moving them to ~/.dotfiles-backup..."
  dotfiles checkout 2>&1 | grep -E "^\s+\." | awk {'print $1'} | while read -r file; do
    mkdir -p "$(dirname "$WORK_TREE/.dotfiles-backup/$file")"
    mv "$WORK_TREE/$file" "$WORK_TREE/.dotfiles-backup/$file"
  done
}

echo "[*] Checking out dotfiles..."
dotfiles checkout

echo "[*] Configuring dotfiles git settings..."
dotfiles config --local status.showUntrackedFiles no

echo "[*] Adding dotfiles alias to shell config..."
SHELL_RC="$HOME/.bashrc"
grep -q "$ALIAS_NAME" "$SHELL_RC" || echo "alias $ALIAS_NAME='/usr/bin/git --git-dir=$DOTFILES_DIR --work-tree=$WORK_TREE'" >> "$SHELL_RC"

echo "[✔] Dotfiles setup complete. Restart your shell or run: source ~/.bashrc"

