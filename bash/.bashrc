#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Outputs
# green color: [38;5;41m]
# blue color: [38;5;68m]
PS1="\[\033[38;5;68m\][\u@\h\[$(tput sgr0)\] \[\033[38;5;244m\]\W\[\033[38;5;68m\]]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"
LS_COLORS=$LS_COLORS:'di=0;35:'; export LS_COLORS

shopt -s extglob
set -o vi
set -o ignoreeof

# Source
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# Aliases
alias startw='WLR_DRM_DEVICES=/dev/dri/by-name/intel MESA_VK_DEVICE_SELECT=8086:9a60! sway'
alias bootwindows='sudo efibootmgr -n 0001 && reboot'
alias ls='ls --color=auto'
alias vim='vim --servername vim'
alias grep='grep --color=auto'
alias suspend='systemctl suspend'
alias ncwd='foot & disown'
alias fpac='find /etc -regextype posix-extended -regex ".+\.pac(new|save|orig)" 2> /dev/null'
alias fbsym='find . -type l -! -exec test -e {} \; -print'
alias updmirrorlist="sudo reflector --verbose -c 'United States' -l 200 -p http -f 20 --sort rate --save /etc/pacman.d/mirrorlist"
alias rsyncfat='rsync --modify-window=1'
alias yt-dlp-pip-install='pip install -U --pre "yt-dlp[default,curl-cffi]"'
alias yt-dlp-ba='yt-dlp -f "ba" -x --embed-metadata --parse-metadata "playlist_index:%(track_number)s" -o "%(playlist_index)02d. %(title)s.%(ext)s" --embed-thumbnail'
alias yt-dlp-ba-split='yt-dlp -f "ba" -x --embed-metadata --split-chapters -o "chapter:%(section_number)02d. %(section_title)s.%(ext)s"'
alias yt-dlp-1080avc='yt-dlp -f "(bv*[height<=?1080][vcodec~='\''^(avc|h264)'\'']+ba)"'
alias bannedcamp='python $HOME/school/compsci/misc/bandcamp_not_safe/dl_album.py'
alias muxivfarm='python $HOME/school/compsci/misc/muxiv_farmer/dl_album.py'
alias riptistory='python $HOME/school/compsci/misc/rip_tistory/dl_album.py'
alias mpv-powersave="mpv --profile=powersave"

# Python venv
alias venv-streamrip='source ~/.venv/streamrip/bin/activate'
alias venv-yt-dlp='source ~/.venv/yt-dlp-pip/bin/activate'

# Temporary aliases

# Environment Variables
export VISUAL="vim"
export EDITOR="$VISUAL"
export BROWSER="qutebrowser"
export R_ENVIRON_USER="~/.config/R/.Renviron"
export CLASSPATH="/usr/share/java/junit.jar:/usr/share/java/hamcrest-core.jar:./"
export PYTHONSTARTUP="$HOME/.python_startup.py"
export PYTHON_BASIC_REPL=1
export FZF_DEFAULT_COMMAND="command fd --hidden --follow --exclude \".git\" ."
export FZF_ALT_C_COMMAND="command fd --type d --hidden --follow --exclude \".git\" ."
#export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \\( -path '*.git' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune -o -type d -print 2> /dev/null | cut -b 3-"
export FZF_DEFAULT_OPTS="--bind=ctrl-h:half-page-up,ctrl-l:half-page-down"
export PYTHONBREAKPOINT="ipdb.set_trace"
export RUSTUP_HOME="$HOME/.rust/rustup"
export CARGO_HOME="$HOME/.rust/cargo"

# Functions
7zxo() {
    7z x -o"${1%.*}" "$1"
}

cl() {
    if [[ "$#" -eq 0 ]] || [[ "${@: -1}" == -* ]]; then
        local dir=$HOME
    else
        local dir="${@: -1}"
        set -- "${@:1:$(($#-1))}"
    fi

    cd "$dir" && ls "$@"
}
_fzf_setup_completion path cl

ddcbrightness() {
    ddcutil setvcp 10 $1
}

ddcgain() {
    ddcutil setvcp 16 $1
    ddcutil setvcp 18 $1
    ddcutil setvcp 1A $1
}

find_containing() {
    # list files matching $1 that contain $2
    find ./ -name "$1" -exec grep -l "$2" {} +
}

mergepdf() {
    outputfile="$1"
    shift
    gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOUTPUTFILE="$outputfile" "$@"
}

prevpac() {
    expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n $1
}

zathura_tail() {
    start_pattern=$1

    ls_v=$(ls -v)
    start=$(echo "${ls_v}" | grep -n "${start_pattern}" | head -n 1 | cut -d ':' -f 1)
    limit=$(echo "${ls_v}" | wc -l)

    echo "${ls_v}" | tail -n $((${limit} - ${start} + 1)) | xargs -n 1 -d '\n' zathura
}

zpdfd() {
    zathura "$1" & disown
}

# Temporary Functions
