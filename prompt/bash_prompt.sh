# ~/.dotfiles/prompt/bash_prompt.sh

# Colors
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
YELLOW="\[\033[0;33m\]"
RESET="\[\033[0m\]"

# Kubernetes context snippet
__kube_ps1() {
    if command -v kubectl >/dev/null 2>&1; then
        ctx=$(kubectl config current-context 2>/dev/null)
        ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
        [ -n "$ctx" ] && echo -n "☸️ ${ctx}${ns:+.$ns} "
    fi
}

PS1="${GREEN}\u@\h${RESET} ${BLUE}\w${RESET} \$(__kube_ps1)\n${YELLOW}➜${RESET} "
