ZDOTDIR="$HOME/.config/zsh"
COLORTERM="truecolor"
EDITOR="nvim"
MANPAGER="nvim +Man!"

# FZF
 FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --preview 'bat --color=always {}'"
 FZF_DEFAULT_COMMAND='fd --type f --hidden --ignore-file $HOME/.config/fd/ignore'
 FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
