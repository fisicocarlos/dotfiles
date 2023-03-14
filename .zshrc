if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme
# curl from github
source ~/.config/zsh/plugin/sudo.plugin.zsh
# apt install zsh-syntax-highlighting
source ~/.config/zsh/plugin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/plugin/zsh-autosuggestions
source ~/.config/zsh/plugin/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customtion function file.
# generated by genzsize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -F'
alias r='ranger .'
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias cat='bat --plain --paging=never'
alias mkt='cd $(mktemp -d)'

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

#ctrl-space for autocomplete
bindkey '^ ' autosuggest-accept

#export PATH=$HOME/.local/bin:$PATH
# raspberry commands  RASPI_USER='carlos'
RASPI_USER='carlos'
RASPI_HOST='raspi.local'
RASPI="${RASPI_USER}@${RASPI_HOST}"
alias sshpi="ssh ${RASPI}"
scpi () {
  scp $1 ${RASPI}:$2
}
alias r="ranger"
. "$HOME/.cargo/env"


[ -f ~/.config/fzf/.fzf.zsh ] && source ~/.config/fzf/.fzf.zsh
