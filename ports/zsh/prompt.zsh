# vi Mode
bindkey -v
export KEYTIMEOUT=1
zle -N zle-keymap-select

# no cd required
setopt autocd nomatch notify

# coloured prompt
autoload -U colors && colors

# mass autorename
autoload -U zmv

# vi prompt
precmd() {
    PROMPT="%{$fg[cyan]%}$%{$reset_color%} "

    # set window title
    print -Pn "\e]0;%~\a"
}

zle-keymap-select() {
    PROMPT="%{$fg[cyan]%}$%{$reset_color%} "

    [[ $KEYMAP = vicmd ]] && PROMPT="%{$fg[magenta]%}$%{$reset_color%} "
    zle reset-prompt
}

# RPROMPT="%{$fg[cyan]%} %~ %{$reset_color%}"

# auto completion
autoload -U compinit; compinit -D

# superglobs
setopt extendedglob
unsetopt caseglob

# ls colours
test -x "$(whence -p dircolors)" && {
    eval "$(dircolors ~/.zsh/lscolours)"
    alias ls='ls -N -F --color=auto'
} || {
    alias ls='ls -N -F'
}

# load reporting
REPORTTIME=60
