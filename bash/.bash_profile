#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start SSH agent at login
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
