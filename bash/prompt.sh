# --- Colors (ANSI-safe, clean version) ---
RESET="\[\e[0m\]"
BOLD="\[\e[1m\]"
DIM="\[\e[2m\]"
GREEN="\[\e[32m\]"
RED="\[\e[31m\]"
YELLOW="\[\e[33m\]"
BLUE="\[\e[34m\]"
MAGENTA="\[\e[35m\]"
CYAN="\[\e[36m\]"

# --- Git branch + dirty state ---
__git_ps1_simple() {
    if command -v git >/dev/null 2>&1 && { [ -d .git ] || git rev-parse --is-inside-work-tree >/dev/null 2>&1; }; then
        branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
        dirty=$(git status --porcelain 2>/dev/null | grep -q . && echo "*" || echo "")
        echo -n "${MAGENTA}git:${branch}${dirty}${RESET} "
    fi
}

# --- Kubernetes context + namespace ---
__kube_ps1() {
    command -v kubectl >/dev/null 2>&1 || return
    ctx=$(kubectl config current-context 2>/dev/null)
    ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
    [ -n "$ctx" ] && echo -n "${CYAN}k8s:${ctx}${ns:+.$ns}${RESET} "
}

# --- Optional: show last command duration (>3s) ---
__last_cmd_time() {
    [ -n "$LAST_CMD_DURATION" ] && [ "$LAST_CMD_DURATION" -gt 3 ] &&
        printf "%s[%ss]%s " "${DIM}" "$LAST_CMD_DURATION" "${RESET}"
}

# --- Timing hook for command duration ---
PROMPT_COMMAND='LAST_CMD_START=$SECONDS; history -a; history -n'
trap 'LAST_CMD_DURATION=$((SECONDS - LAST_CMD_START))' DEBUG

# --- Final prompt ---
PS1="${GREEN}\u@\h${RESET} ${BLUE}\w${RESET} \$(__git_ps1_simple)\$(__kube_ps1)\$(__last_cmd_time)\n${YELLOW}➜${RESET} "
