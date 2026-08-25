# .bashrc

alias cat='bat --paging=never'
#alias k='kubectl'
alias k='kubecolor'
alias kc='kubectx'
alias kn='kubens'
alias kd='k describe'
alias kg='k get'
alias ke='k edit'
alias kl='k logs'
alias ac='python3 /usr/local/bin/access_customer.py'
alias dc='yq ".data | with_entries(.value |= @base64d)"'
alias ossl="openssl x509 -noout -text -in"
alias copy='xclip -selection clipboard'
alias argoadmin="k get secrets -n infra-argocd argocd-initial-admin-secret -ojsonpath='{.data.password}' | base64 -d | copy"

eval "$(fzf --bash)"

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

### CUSTOM CONFIG ###

# Run TMUX by default
if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
  # Adapted from https://unix.stackexchange.com/a/176885/347104
  # Create session 'main' or attach to 'main' if already exists.
  tmux new-session -A -s main
fi

# Only load Liquidprompt in interactive shells, not from a script or from scp
[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt
export PATH="$HOME/.tfenv/bin:$PATH"
source <(kubectl completion bash)
complete -o default -F __start_kubectl k
export PATH="$PATH:$HOME/flutter/flutter/bin"
export PATH="$PATH:$HOME/Android/Sdk/cmdline-tools/latest/bin/"

