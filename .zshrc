# The following lines were added by compinstall

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle :compinstall filename '/home/carlos/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

# set PATH so it includes cargo bin if it exists
if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

# >>> coursier install directory >>>
if [ -d "$HOME/.local/share/coursier" ]; then
    PATH="$PATH:/home/carlos/.local/share/coursier/bin"
fi
# <<< coursier install directory <<<

export JAVA_HOME=/usr/lib/jvm/java-25-openjdk
export PATH=$JAVA_HOME/bin:$PATH


# pyenv
export PYENV_ROOT="$HOME/.pyenv"

if [ -d "$PYENV_ROOT/bin" ]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init - --zsh)"
fi

PYTHON_VENV_NAME=".venv"
PYTHON_VENV_NAMES=($PYTHON_VENV_NAME venv)
PYTHON_AUTO_VRUN=true

plugins=(sudo zsh-autosuggestions git scala python fzf zsh-syntax-highlighting pyenv docker)
export ZSH="$HOME/.config/oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh


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
alias vim=nvim
alias vi=nvim

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
if [ -x /usr/bin/bat ]; then
    alias cat='bat --paging=never'
    alias less='bat --paging=always --style=full'
    export PAGER=less
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export MANROFFOPT="-c"
fi

alias r='ranger'
alias sshpi='ssh carlos@raspberrypi.local'


#ctrl-space for autocomplete
bindkey '^ ' autosuggest-accept

# git dotfiles bare repo
# https://www.atlassian.com/git/tutorials/dotfiles
# Wrapper function para dotfiles
# Wrapper function para dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME'
compdef config=git

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Yazi command
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
