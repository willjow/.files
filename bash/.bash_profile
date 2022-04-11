#
# ~/.bash_profile
#
eval "$(/opt/homebrew/bin/brew shellenv)"

[[ -f ~/.bashrc ]] && . ~/.bashrc

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
