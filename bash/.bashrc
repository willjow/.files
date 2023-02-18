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

# efibootmgr command:
#efibootmgr --create --disk /dev/sda --part 1 --label "Arch Linux acpi_osi" --loader /vmlinuz-linux --unicode 'root=/dev/sda2 rw initrd=/intel-ucode.img initrd=/initramfs-linux.img acpi_osi=Linux'

shopt -s extglob
set -o vi
set -o ignoreeof

# Source
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# Aliases
alias suspend='systemctl suspend'
alias ls='ls --color=auto'
alias vim='vim --servername vim'
alias grep='grep --color=auto'
alias please='sudo bash -c "$(history -p !!)"'
alias alsaequal='alsamixer -D equal'
alias fpac='find /etc -regextype posix-extended -regex ".+\.pac(new|save|orig)" 2> /dev/null'
alias fbsym='find . -type l -! -exec test -e {} \; -print'
alias updmirrorlist="sudo reflector --verbose -c 'United States' -l 200 -p http -f 20 --sort rate --save /etc/pacman.d/mirrorlist"
alias clearpac='sudo paccache -rk2 && paccache -ruk0'
alias plugvga='xrandr --output VGA-1 --left-of eDP-1 --auto && . ~/.fehbg'
alias plughdmi='xrandr --output HDMI-1 --right-of eDP-1 --auto && . ~/.fehbg'
alias plugdp='xrandr --output DP-1 --right-of eDP-1 --mode 1920x1080 --rate 165 && . ~/.fehbg'
alias switchdp='xrandr --output eDP-1 --off && xrandr --output DP-1 --mode 1920x1080 --rate 165 && xset s off -dpms && . ~/.fehbg'
alias unplug='xrandr --output VGA-1 --off; xrandr --output DP-1 --off; xrandr --output HDMI-1 --off; xrandr --output eDP-1 --auto; . ~/.fehbg'
alias ntetris='~/school/compsci/misc/dank-nooodls-vitetris/tetris'
alias lpr-4tile='lpr -o number-up=4 -o orientation-requested=5 -o number-up-layout-btlr -o sides=two-sided-long-edge'
alias swe5='feh --zoom 33 ~/misc/bikes/swe5.jpg & disown'
alias tcr='feh --zoom 33 ~/misc/bikes/tcr.jpg & disown'
alias left_gif='byzanz-record -v -x 1 -y 17 -w 681 -h 750'
alias resettp='sh ~/.reset_tp.sh'
alias ncwd='urxvt & disown'
alias rewi='sudo systemctl restart netctl-auto@wlp3s0'
alias bton="bluetoothctl -- power on"
alias btoff="bluetoothctl -- power off"
alias reencodemp3all='for dir in ./*; do reencodemp3dir "$dir"; done'
alias yt-dlp-mp3='yt-dlp -x --audio-format mp3 --audio-quality 0'
alias bannedcamp='python $HOME/school/compsci/misc/bandcamp_not_safe/dl_album.py'
alias muxivfarm='python $HOME/school/compsci/misc/muxiv_farmer/dl_album.py'
alias riptistory='python $HOME/school/compsci/misc/rip_tistory/dl_album.py'
alias wifi-stop='sudo systemctl stop netctl-auto@wlp3s0.service'
alias wifi-start='sudo systemctl start netctl-auto@wlp3s0.service'

# Temporary aliases

# Environment Variables
export BROWSER="qutebrowser"
export R_ENVIRON_USER="~/.config/R/.Renviron"
export CLASSPATH="/usr/share/java/junit.jar:/usr/share/java/hamcrest-core.jar:./"
export PYTHONSTARTUP="$HOME/.python_startup.py"
export FZF_DEFAULT_COMMAND="command fd --hidden --follow --exclude \".git\" ."
export FZF_ALT_C_COMMAND="command fd --type d --hidden --follow --exclude \".git\" ."
#export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \\( -path '*.git' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune -o -type d -print 2> /dev/null | cut -b 3-"
export FZF_DEFAULT_OPTS="--bind=ctrl-h:half-page-up,ctrl-l:half-page-down"
export PYTHONBREAKPOINT="ipdb.set_trace"

# Functions
wipedisk() {
  if [[ -e "$1" && -b "$1" ]];then
    NOT_safe="$(lsblk -o "NAME,MOUNTPOINT" ${1//[0-9]/} | grep -e / -e '\]')";
    if [[ -z "$NOT_safe" ]];then
      sudo dd if=/dev/zero of="$1"
      # Here you can use any of your favourite wiping tools
      # to wipe destination passed on command line and stored in variable "$1"
      #
    else
      echo 'Not allowed to destroy if any of the partitions is mounted: '"$NOT_safe"
      fi
      fi
    }

find_containing() {
    # list files matching $1 that contain $2
    find ./ -name "$1" -exec grep -l "$2" {} +
}

cplsty() {
  cp $HOME/school/latextemplates/style.sty ${1-style.sty}
}

cpldoc() {
  cp $HOME/school/latextemplates/document.tex ${1-document.tex}
}

zpdfd() {
  zathura "$1" & disown
}

javacr() {
  javac $1 && java $(echo $1 | awk -F '.java' '{print $1}')
}

junittest() {
  java org.junit.runner.JUnitCore $(echo $1 | awk -F '.java' '{print $1}')
}

prevpac() {
  expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n $1
}

adbaddmusic() {
  adb push ~/music/ /sdcard/Music/
}

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

mergepdf() {
  outputfile="$1"
  shift
  gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOUTPUTFILE="$outputfile" "$@"
}

silenceremove() {
    ffmpeg -i "$1" -af "silenceremove=start_periods=1:start_duration=0:start_threshold=0.04:detection=peak,areverse,silenceremove=start_periods=1:start_duration=0:start_threshold=0.04:detection=peak,areverse" "$2"
}

silenceremovedir() {
  inputdir=$1
  outputdir=${inputdir%/}_silenceremoved
  mkdir "$outputdir"

  for inputfile in "${inputdir}"/*.mp3; do
    outputfile=${outputdir}/$(basename "$inputfile")
    silenceremove "$inputfile" "$outputfile"
  done
}

libmp3lame_convert() {
  ffmpeg -i "$2" -c:a libmp3lame -q:a 0 -map_metadata 0 -y "${2%.*}.$1"
}

flacify() {
  ffmpeg -i "$1" -c:a flac -compression_level 0 -y "${1%.*}.flac"
}

converttomp3() {
  # for some reason libmp3lame causes seeking problems and lame doesn't
  sourcef="$1"
  base="${sourcef%.*}"
  ext="${sourcef##*.}"
  mp3="${base}.mp3"
  wav="${base}.wav"
  libmp3lame_convert wav "$sourcef"
  lame -V 0 "$wav" "$mp3"
  rm -v "$wav" "$sourcef"
}

converttomp3dir() {
  for f in "$1"/*.$2; do
    converttomp3 "$f"
  done
}

reencodemp3() {
  # for some reason libmp3lame causes seeking problems and lame doesn't
  mp3="$1"
  base="${mp3%.mp3}"
  tagged="${base}_tagged.mp3"
  mv -v "$mp3" "$tagged"
  lame --mp3input -V 0 "$tagged" "$mp3"
  id3cp "$tagged" "$mp3"
  rm -v "$tagged"
}

reencodemp3dir() {
  for mp3 in "$1"/*.mp3; do
    reencodemp3 "$mp3"
  done
}

ddcbrightness() {
    ddcutil setvcp 10 $1
}

ddcgain() {
    ddcutil setvcp 16 $1
    ddcutil setvcp 18 $1
    ddcutil setvcp 1A $1
}

qutehistory() {
    sqlite3 ~/.qutebrowser_history "select * from history where url='$1';"
}

# Temporary Functions
