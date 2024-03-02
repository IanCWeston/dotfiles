#!/bin/sh

set -e # -e: exit on error

GITHUB_USERNAME="IanCWeston"

if [ ! "$(command -v chezmoi)" ]; then

  if [ "$(command -v curl)" ] || [ "$(command -v wget)" ]; then
    sh -c chezmoi_install.sh # pre-downloaded from http://get.chezmoi.io/lb
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi

    # exec: replace current process with chezmoi init
    exec chezmoi init --apply $GITHUB_USERNAME
fi

