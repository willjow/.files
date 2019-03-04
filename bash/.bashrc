#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Outputs
PS1="\[\033[38;5;41m\][\u@\h\[$(tput sgr0)\] \[\033[38;5;244m\]\W\[\033[38;5;41m\]]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

# efibootmgr command:
#efibootmgr --disk /dev/sda --part 1 --create --label "Arch Linux No IPV6 psmouse" --loader /vmlinuz-linux --unicode 'root=/dev/sda2 rw initrd=/intel-ucode.img initrd=/initramfs-linux.img ipv6.disable=1'

#Aliases
alias ls='ls --color=auto'
alias vim='vim --servername vim'
alias cower='cower -t ~/aur'
alias please='sudo bash -c "$(history -p !!)"'
alias fpac='find /etc -regextype posix-extended -regex ".+\.pac(new|save|orig)" 2> /dev/null'
alias fbsym='find . -type l -! -exec test -e {} \; -print'
alias updmirrorlist="sudo reflector -c 'United States' -l 200 -p http -f 20 --sort rate --save /etc/pacman.d/mirrorlist"
alias plugvga='xrandr --output VGA1 --left-of LVDS1 --auto && . ~/.fehbg'
alias plugdp='xrandr --output HDMI1 --left-of LVDS1 --auto && . ~/.fehbg'
alias unplug='xrandr --output VGA1 --off && xrandr --output HDMI1 --off && . ~/.fehbg'
alias ntetris='~/school/compsci/misc_projects/dank-nooodls-vitetris/tetris'
alias cs61bstyle='python3 ~/school/compsci/cs61b/aqr/javalib/style61b.py *.java'
alias proxyon='export http_proxy="proxy.lib.berkeley.edu:7777" && export https_proxy=$http_proxy'
alias proxyoff='unset http_proxy https_proxy'
alias lpr-4tile='lpr -o number-up=4 -o orientation-requested=5 -o number-up-layout-btlr -o sides=two-sided-long-edge'
alias bike='feh --zoom 33 ~/misc/s_works_e5.jpg & disown'
alias bannedcamp='python /home/wjow/school/compsci/misc_projects/bandcamp_not_safe/dl_album.py'
alias left_gif='byzanz-record -v -x 1 -y 17 -w 681 -h 750'

#Environment Variables
export PATH="${PATH}"
export BROWSER="qutebrowser"
export R_ENVIRON_USER="~/.config/r/.Renviron"
export CS61B_LIB="/home/wjow/school/compsci/cs61b/aqr/javalib/algs4.jar:/home/wjow/school/compsci/cs61b/aqr/javalib/jh61b.jar:/home/wjow/school/compsci/cs61b/aqr/javalib/stdlib.jar:/home/wjow/school/compsci/cs61b/aqr/javalib/stdlib-package.jar:/home/wjow/school/compsci/cs61b/aqr/javalib/checkstyle-6.15-all.jar:/home/wjow/school/compsci/cs61b/aqr/javalib/61b_checks.xml"
export CLASSPATH="${CLASSPATH}:/usr/share/java/junit.jar:/usr/share/java/hamcrest-core.jar:${CS61B_LIB}:./"
export PYTHONSTARTUP="/home/wjow/.python_startup.py"
export GOPATH="/home/wjow/.go/"


#Functions
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

mergepdf() {
    outputfile=$1
    shift
    gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOUTPUTFILE=$outputfile "$@"
}

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

shopt -s extglob
set -o vi
set -o ignoreeof
