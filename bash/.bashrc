#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Outputs
PS1="\[\033[38;5;41m\][\u@\h\[$(tput sgr0)\] \[\033[38;5;244m\]\W\[\033[38;5;41m\]]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

#Aliases
alias vim='vim --servername vim'
alias ls='ls --color=auto'
alias cower='cower -t ~/aur'
alias please='sudo bash -c "$(history -p !!)"'
alias fpac='find /etc -regextype posix-extended -regex ".+\.pac(new|save|orig)" 2> /dev/null'
alias fbsym='find . -type l -! -exec test -e {} \; -print'
alias updatemirrorlist="sudo reflector -c 'United States' -l 200 -p http -f 20 --sort rate --save /etc/pacman.d/mirrorlist"
alias plugvga='xrandr --output VGA1 --left-of LVDS1 --auto && . ~/.fehbg'
alias plugdp='xrandr --output HDMI1 --right-of LVDS1 --auto && . ~/.fehbg'
alias unplug='xrandr --output VGA1 --off && xrandr --output HDMI1 --off && . ~/.fehbg'
alias ntetris='~/school/compsci/misc_projects/dank-nooodls-vitetris/tetris'
alias cs61bstyle='python3 ~/school/compsci/cs61b/aqr/javalib/style61b.py *.java'

#Environment Variables
export PATH="${PATH}"
export R_ENVIRON_USER="~/.config/r/.Renviron"
export CS61B_LIB="/home/wjow/school/compsci/cs61b/aqr/javalib/algs4.jar:/home/wjow/school/compsci/cs61b/aqr/javalib/jh61b.jar:/home/wjow/school/compsci/cs61b/aqr/javalib/stdlib.jar:/home/wjow/school/compsci/cs61b/aqr/javalib/stdlib-package.jar:/home/wjow/school/compsci/cs61b/aqr/javalib/checkstyle-6.15-all.jar:/home/wjow/school/compsci/cs61b/aqr/javalib/61b_checks.xml"
export CLASSPATH="${CLASSPATH}:/usr/share/java/junit.jar:/usr/share/java/hamcrest-core.jar:${CS61B_LIB}:./"


#Functions
javacr() {
    javac $1 && java $(echo $1 | cut -d. -f1)
}

junittest() {
    java org.junit.runner.JUnitCore $(echo $1 | cut -d. -f1)
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

set -o vi
