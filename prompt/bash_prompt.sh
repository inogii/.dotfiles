# --- Colors (ANSI-safe) ---
RESET="\[\033[0m\]"
BOLD="\[\033[1m\]"
DIM="\[\033[2m\]"
GREEN="\[\033[0;32m\]"
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
MAGENTA="\[\033[0;35m\]"
CYAN="\[\033[0;36m\]"

# --- Git branch + dirty state ---
__git_ps1_simple() {
    # cheap check, doesn't invoke git status
    if command -v git >/dev/null 2>&1 && [ -d .git ] || git rev-parse --git-dir >/dev/null 2>&1; then
        branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
        dirty=$(git status --porcelain 2>/dev/null | grep -q . && echo "*" || echo "")
        echo -n "${MAGENTA} ${branch}${dirty}${RESET} "
    fi
}

# --- Kubernetes context + namespace ---
__kube_ps1() {
    command -v kubectl >/dev/null 2>&1 || return
    ctx=$(kubectl config current-context 2>/dev/null)
    ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
    [ -n "$ctx" ] && echo -n "${CYAN}k8s ${ctx}${ns:+.$ns}${RESET} "
}

# --- Optional: show last command duration (>3s) ---
__last_cmd_time() {
    [ -n "$LAST_CMD_DURATION" ] && [ "$LAST_CMD_DURATION" -gt 3 ] &&
        printf "%s[%ss]%s " "${DIM}" "$LAST_CMD_DURATION" "${RESET}"
}

# record timing hooks
PROMPT_COMMAND='LAST_CMD_START=$SECONDS; history -a; history -n'
precmd() { :; }
trap 'LAST_CMD_DURATION=$((SECONDS - LAST_CMD_START))' DEBUG

# --- Build the final prompt ---
PS1="${GREEN}\u@\h${RESET} ${BLUE}\w${RESET} \$(__git_ps1_simple)\$(__kube_ps1)\$(__last_cmd_time)\n${YELLOW}➜${RESET} "
