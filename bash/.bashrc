#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Outputs
# pikles color: [38;5;41m]
# empoleon color: [38;5;68m]
PS1="\[\033[38;5;68m\][\u@\h\[$(tput sgr0)\] \[\033[38;5;244m\]\W\[\033[38;5;68m\]]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"
LS_COLORS=$LS_COLORS:'di=0;35:'; export LS_COLORS

shopt -s extglob
set -o vi
set -o ignoreeof
export EDITOR=vim

# Source

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias csgo='cd /mnt/g/Program\ Files\ \(x86\)/Steam/SteamApps/common/Counter-Strike\ Global\ Offensive/csgo'
alias tf='cd /mnt/g/Program\ Files\ \(x86\)/Steam/SteamApps/common/Team\ Fortress\ 2/tf'

#export FZF_DEFAULT_COMMAND="command fd --hidden --follow --exclude \".git\" ."
#export FZF_ALT_C_COMMAND="command fd --type d --hidden --follow --exclude \".git\" ."

#export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \\( -path '*.git' -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune -o -type d -print 2> /dev/null | cut -b 3-"

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
#_fzf_setup_completion path cl

mergepdf() {
  outputfile=$1
  shift
  gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOUTPUTFILE=$outputfile "$@"
}
