# ---------------------------------------------------------------------------
# Antidote — plugin manager
# ---------------------------------------------------------------------------
source ${HOME}/.antidote/antidote.zsh
antidote load ${ZDOTDIR:-~}/.zsh_plugins.txt

# ---------------------------------------------------------------------------
# Keybindings
# ---------------------------------------------------------------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ---------------------------------------------------------------------------
# History
# ---------------------------------------------------------------------------
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# ---------------------------------------------------------------------------
# Completions
# ---------------------------------------------------------------------------
autoload -Uz compinit
# Only refresh completions once per day
if [[ -n $ZDOTDIR/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ---------------------------------------------------------------------------
# Environment
# ---------------------------------------------------------------------------
export COLORTERM="truecolor"
export EDITOR="nvim"
export MANPAGER="nvim +Man!"

export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --preview 'bat --color=always {}'"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --ignore-file $HOME/.config/fd/ignore'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ---------------------------------------------------------------------------
# Aliases
# ---------------------------------------------------------------------------
alias l='eza'
alias ll='eza -la'
alias tree='eza --icons --tree'
alias lg='lazygit'
alias gl='glab'
alias cls='clear'

alias v='nvim'
alias t='tmux'
alias tp='tmuxp'
alias f='fzf | xargs nvim'

# Kubernetes
alias kcx='kubectx'
alias kns='kubens'

# Docker
alias d='sudo docker'

# ---------------------------------------------------------------------------
# Custom functions
# ---------------------------------------------------------------------------
tool_exists() { command -v "$1" &>/dev/null; }
source $ZDOTDIR/custom_functions

# ---------------------------------------------------------------------------
# Shell integrations
# ---------------------------------------------------------------------------
tool_exists fzf        && eval "$(fzf --zsh)"
tool_exists zoxide     && eval "$(zoxide init --cmd cd zsh)"
tool_exists oh-my-posh && eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/zen.yaml)"
tool_exists atuin      && eval "$(atuin init zsh --disable-up-arrow)"
tool_exists mise       && eval "$(mise activate zsh)"
