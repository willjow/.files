#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH="$PATH:/var/lib/flatpak/exports/bin/"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
