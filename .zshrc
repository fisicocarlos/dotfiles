if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH


# set PATH so it includes cargo bin if it exists
if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi
# set PATH so it includes tex bin if it exists
if [ -d "/usr/local/texlive/2024/bin/x86_64-linux" ] ; then
    PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
fi

export ZSH="$HOME/.config/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

PYTHON_VENV_NAME=".venv"
PYTHON_VENV_NAMES=($PYTHON_VENV_NAME venv)
PYTHON_AUTO_VRUN=true

plugins=(sudo zsh-autosuggestions git scala python fzf zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zoxide command
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# History
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory
setopt SHARE_HISTORY
HISTFILE=~/.cache/zsh/history
if [ ! -d $(dirname "$HISTFILE") ]; then
    mkdir -p $(dirname "$HISTFILE")
fi
if [ ! -f "$HISTFILE" ]; then
    touch "$HISTFILE"
fi

# Editor default
export VISUAL=nvim
export EDITOR="$VISUAL"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#ls | lsd commands
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
if [ -x /usr/bin/lsd ]; then
    alias ls='lsd'
    alias l='lsd -l'
    alias la='lsd -a'
    alias lla='lsd -la'
    alias lt='lsd --tree'
fi

# https://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo#22043
alias sudo='sudo '

# https://github.com/sharkdp/bat
if [ -x /usr/bin/batcat ]; then
    alias cat='batcat --paging=never'
    alias less='batcat --paging=always'
    export PAGER=less
    export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
    export MANROFFOPT="-c"
fi

alias r='ranger'
alias mktemp='cd $(/usr/bin/mktemp -d)'
alias sshpi='ssh carlos@raspberrypi.local'

#ctrl-space for autocomplete
bindkey '^ ' autosuggest-accept

# git dotfiles bare repo 
# https://www.atlassian.com/git/tutorials/dotfiles
# Wrapper function para dotfiles
# Wrapper function para dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME'
compdef config=git


# >>> Added by Spyder >>>
alias spyder=/home/carlos/.local/spyder-6/envs/spyder-runtime/bin/spyder
alias uninstall-spyder=/home/carlos/.local/spyder-6/uninstall-spyder.sh
# <<< Added by Spyder <<<
