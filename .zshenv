export ZDOTDIR="$HOME/.config/zsh"

# Bootstrap defaults to the personal profile; preserve an explicitly selected profile.
export MISE_ENV="${MISE_ENV:-personal}"

# Make mise-managed binaries available to all shell types (login, non-interactive, etc.)
# Full `mise activate` runs later in .zshrc for interactive shells
if [[ -f "$HOME/.local/bin/mise" ]]; then
    export PATH="$HOME/.local/bin:$PATH"
    eval "$($HOME/.local/bin/mise activate zsh --shims)"
fi
