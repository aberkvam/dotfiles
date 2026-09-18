#!/usr/bin/bash


### Prevent CRTL-D from exiting the shell
set -o ignoreeof


### Load defaults in ansible devcontainer
direnv allow


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

export STARSHIP_CONFIG=~/dotfiles/starship.toml
