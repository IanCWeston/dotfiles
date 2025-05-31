#!/bin/bash

set -e # -e: exit on error

function command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# curl is needed to install mise and chezmoi
command_exists curl || { echo "Error: curl is not installed."; exit 1; }

# install mise
command_exists mise || curl https://mise.run | sh
# install chezmoi
command_exists chezmoi || sh -c "$(curl -fsLS get.chezmoi.io/lb)"

# exec: replace current process with chezmoi init
exec chezmoi init --apply IanCWeston

