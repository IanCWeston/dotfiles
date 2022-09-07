# Set up the prompt

# autoload -Uz promptinit
# promptinit
# prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# General
set -o vi # Vi shell
export EDITOR="/usr/bin/nvim"
export COLORTERM="truecolor"
alias ll='exa -l'
alias tree='exa --icons --tree'
alias lg='lazygit'
alias cls='clear'

alias gf='/home/westoia/scripts/personal/pull_firewall_config.sh'
alias n='nvim'
alias tm='tmux'

# Custom functions

# search ssh config
function s() {
  if ! command -v fzf > /dev/null 2>&1; then
    echo "Please install fzf"
    exit
  else
    eval ssh $(grep '^Host\s' ~/.ssh/config | cut -d ' ' -f 2 | fzf)
  fi
}

# Find out what flags do
function argshelp() {
  ARGS="${@:2}"
  $1 --help | grep -w -- "-[$ARGS]"
}

# Glab
#eval "$(glab completion -s zsh)"
#alias gl='glab'

# FZF
export FZF_DEFAULT_COMMAND='rg --files --hidden -g !.git/ -g !.apps/'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
source "$HOME/.config/fzf/shell/key-bindings.zsh"

# Zoxide
eval "$(zoxide init zsh)"

# Starship prompt
eval "$(starship init zsh)"

# mcfly
eval "$(mcfly init zsh)"
