#!/usr/bin/env bash
set -euo pipefail

# Wrapper that installs mise and dispatches to `mise bootstrap --adopt`.
# All real configuration lives in mise.toml at the repo root.
#
# Fresh-machine usage (no clone needed):
#   curl -fsSL https://raw.githubusercontent.com/IanCWeston/dotfiles/main/bootstrap.sh | bash
#
# Local re-run (already bootstrapped — repo is now ~/.config/mise/):
#   mise bootstrap --yes
#
# Flags:
#   --offline             skip network phases (packages, repos, tools)
#   DOTFILES_REPO=<url>   env var override for the dotfiles repo URL

DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/IanCWeston/dotfiles.git}"
OFFLINE=false

for arg in "$@"; do
  case "$arg" in
    --offline)    OFFLINE=true ;;
    --help|-h)
      sed -n '2,16p' "$0"; exit 0 ;;
    *) echo "Unknown arg: $arg" >&2; exit 2 ;;
  esac
done

if ! command -v mise >/dev/null 2>&1; then
  echo ">>> Installing mise"
  curl -fsSL https://mise.run | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

echo ">>> Running mise bootstrap --adopt $DOTFILES_REPO"
if [ "$OFFLINE" = true ]; then
  exec mise bootstrap --adopt "$DOTFILES_REPO" --yes \
    --skip packages,repos,tools,task,final-hook
else
  exec mise bootstrap --adopt "$DOTFILES_REPO" --yes
fi
