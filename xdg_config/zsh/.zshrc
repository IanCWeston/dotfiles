# TODO: load plugins with Antidote
# Plugins
source $ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-you-should-use/you-should-use.plugin.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
# bindkey '^[w' kill-region

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

### COMPLETIONS ###
fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)

# Use modern completion system
autoload -Uz compinit && compinit

# FZF completions
source $ZDOTDIR/plugins/fzf-tab/fzf-tab.zsh

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

### Environment Variables
export COLORTERM="truecolor"
export EDITOR="nvim"
export MANPAGER="nvim +Man!"

# FZF
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --preview 'bat --color=always {}'"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --ignore-file $HOME/.config/fd/ignore'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

### Aliases
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
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl describe'

alias kcx='kubectx'
alias kns='kubens'

# Docker
alias d='sudo docker'

### Other files
source $ZDOTDIR/custom_functions

### Shell integrations
# FZF
tool_exists fzf && eval "$(fzf --zsh)"

# Zoxide
tool_exists zoxide && eval "$(zoxide init --cmd cd zsh)"

# Starship prompt
# tool_exists starship && eval "$(starship init zsh)"

# OhMyPosh prompt
tool_exists oh-my-posh && eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/zen.yaml)"

# Atuin
tool_exists atuin && eval "$(atuin init zsh)"

# Mise
tool_exists mise && eval "$($HOME/.local/bin/mise activate zsh)"
