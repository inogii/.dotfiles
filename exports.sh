export EDITOR="nvim"
export PATH="$HOME/.local/bin:$PATH"

# --- History settings ---
export HISTSIZE=50000
export HISTFILESIZE=100000
export HISTCONTROL=ignoredups:erasedups
export HISTIGNORE="ls:cd:pwd:exit:clear"
export PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# --- Productivity defaults ---
export KUBECONFIG="$HOME/.kube/config"
export DOCKER_BUILDKIT=1
export LANG="C.UTF-8"
