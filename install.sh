#!/usr/bin/bash


### Prevent CRTL-D from exiting the shell
set -o ignoreeof


### Load defaults in ansible devcontainer
direnv allow


### Set simple prompt that line wraps correctly

# Show git status in prompt
parse_git_bg() {
  if [[ $(git status -s 2> /dev/null) ]]; then
    echo -e "\033[0;31m"
  else
    echo -e "\033[0;32m"
  fi
}

PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u@\h\[\033[0;34m\]\[\033[0;37m\]:\[\033[0;34m\]\w\[$(parse_git_bg)\]$(__git_ps1)\[\033[0;32m\]\$ \[\033[0m\]'


### Link to external Bitwarden SSH agent

# https://dev.to/wetterkrank/ssh-agent-in-a-vs-code-devcontainer-with-a-external-terminal-49ah
# BitWarden "rbw unlock" pop-up garbles password entry --- https://github.com/doy/rbw/issues/354

for sock in /tmp/vscode-ssh-auth-*.sock; do
[ -S "$sock" ] || continue
SSH_AUTH_SOCK="$sock" ssh-add -l >/dev/null 2>&1 && {
    export SSH_AUTH_SOCK="$sock"
    echo "Using SSH_AUTH_SOCK=$SSH_AUTH_SOCK"
    break
}
done
