#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR=vim

# Outputs
# pikles color: [38;5;41m]
# empoleon color: [38;5;68m]
PS1="\[\033[38;5;68m\][\u@\h\[$(tput sgr0)\] \[\033[38;5;244m\]\W\[\033[38;5;68m\]]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"
export LSCOLORS='Fxxfcxdxbxegedabagacad'

shopt -s extglob
set -o vi
set -o ignoreeof

# Source
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source ~/.dover_env

# Aliases
alias ls='ls -G'
alias grep='grep --color=auto'
alias greppy='grep --color=auto --include=./*py'
alias ncwd='kitty -1 -d "$(pwd -P)" & disown'
alias brewx86="arch -x86_64 /usr/local/bin/brew"

export FZF_DEFAULT_COMMAND="command fd --hidden --follow --exclude \".git\" ."
export FZF_ALT_C_COMMAND="command fd --type d --hidden --follow --exclude \".git\" ."
#export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \\( -path '*.git' -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune -o -type d -print 2> /dev/null | cut -b 3-"
export FZF_DEFAULT_OPTS="--bind=ctrl-h:half-page-up,ctrl-l:half-page-down"

# Functions
7zxo() {
  7z x -o"${1%.*}" "$1"
}

cl() {
  if [[ "$1" == "-a" ]]; then
    local dir="$2"
  else
    local dir="$1"
  fi

  local dir="${dir:=$HOME}"

  if [[ -d "$dir"  ]]; then
    if [[ "$1" == "-a" ]]; then
      cd "$dir" >/dev/null; ls -a
    else
      cd "$dir" >/dev/null; ls
    fi
  else
    echo "bash: cl: $dir: Directory not found"
  fi
}
_fzf_setup_completion path cl

zpdfd() {
  zathura "$1" & disown
}

mergepdf() {
  outputfile=$1
  shift
  gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOUTPUTFILE=$outputfile "$@"
}

git-stash-apply() {
  git stash apply stash@{$1}
}

git-stash-revert() {
  git stash show -p stash@{$1} | git apply --reverse --verbose
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
