#!/usr/bin/env bash
set -euo pipefail

# Wrapper that installs mise and dispatches to `mise bootstrap --adopt`.
# All real configuration lives within the mise-config remote repo
#
# Fresh-machine usage (no clone needed):
#   curl -fsSL https://raw.githubusercontent.com/IanCWeston/dotfiles/main/bootstrap.sh | bash -s -- --profile personal
#
# Local re-run (already bootstrapped — repo is now ~/.config/mise/):
#   mise -E personal bootstrap --yes
#
# Flags:
#   --profile personal|work  select a mise config environment (default: personal)
#   --offline                use the adopted config and skip network-dependent phases
#   --skip-tools             skip mise-managed tool installation

MISE_REPO="https://github.com/IanCWeston/mise-config.git"
OFFLINE=false
SKIP_TOOLS=false
PROFILE=personal

while (($#)); do
  case "$1" in
  --offline)
    OFFLINE=true
    shift
    ;;
  --skip-tools)
    SKIP_TOOLS=true
    shift
    ;;
  --profile)
    if (($# < 2)); then
      echo "--profile requires personal or work" >&2
      exit 2
    fi
    case "$2" in
    personal | work) PROFILE="$2" ;;
    *)
      echo "Invalid profile '$2': expected personal or work" >&2
      exit 2
      ;;
    esac
    shift 2
    ;;
  --help | -h)
    sed -n '2,19p' "$0"
    exit 0
    ;;
  *)
    echo "Unknown arg: $1" >&2
    exit 2
    ;;
  esac
done

if [ "$OFFLINE" = true ]; then
  if ! command -v mise >/dev/null 2>&1; then
    echo "Offline bootstrap requires mise to be installed already" >&2
    exit 1
  fi
  if [ ! -f "$HOME/.config/mise/config.toml" ]; then
    echo "Offline bootstrap requires an adopted config at ~/.config/mise" >&2
    exit 1
  fi

  echo ">>> Running offline mise bootstrap with profile $PROFILE"
  cd "$HOME/.config/mise"
  exec env MISE_OFFLINE=1 mise -E "$PROFILE" bootstrap --yes \
    --skip packages,repos,tools,task,final-hook
fi

if ! command -v mise >/dev/null 2>&1; then
  echo ">>> Installing mise"
  curl -fsSL https://mise.run | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

if command -v apt-get >/dev/null 2>&1; then
  echo ">>> Updating apt repos"
  sudo apt-get update -y
fi

echo ">>> Running mise bootstrap with profile $PROFILE --adopt $MISE_REPO"
if [ "$SKIP_TOOLS" = true ]; then
  exec mise -E "$PROFILE" bootstrap --adopt "$MISE_REPO" --yes --skip tools
fi
exec mise -E "$PROFILE" bootstrap --adopt "$MISE_REPO" --yes
