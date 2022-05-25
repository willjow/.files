#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc

eval "$(/opt/homebrew/bin/brew shellenv)"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/wjow/google-cloud-sdk/path.bash.inc' ]; then . '/Users/wjow/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/wjow/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/wjow/google-cloud-sdk/completion.bash.inc'; fi
