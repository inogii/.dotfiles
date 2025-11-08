# --- Navigation ---
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -lh --color=auto 2>/dev/null || ls -lh'
alias la='ls -lha --color=auto 2>/dev/null || ls -lha'

# --- Git ---
if command -v git >/dev/null 2>&1; then
  alias g='git'
  alias gs='git status'
  alias gl='git log --oneline -10'
  alias gb='git branch'
  alias gc='git commit -m'
fi

# --- Kubernetes ---
if command -v kubectl >/dev/null 2>&1; then
  alias k='kubectl'
  alias kgp='kubectl get pods'
  alias kgs='kubectl get svc'
  alias kn='kubectl get nodes'
  alias kl='kubectl logs -f'
  alias kd='kubectl describe'
  alias kctx='kubectl config use-context'
  alias kns='kubectl config set-context --current --namespace'
  alias kx='kubectl exec -it'
  alias kdel='kubectl delete pod'
fi

# --- Docker ---
if command -v docker >/dev/null 2>&1; then
  alias d='docker'
  alias dc='docker compose'
  alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
  alias di='docker images'
  alias drm='docker rm -f'
  alias drmi='docker rmi -f'
fi

# --- Helm ---
if command -v helm >/dev/null 2>&1; then
  alias h='helm'
  alias hl='helm list --all-namespaces'
  alias hi='helm install'
  alias hu='helm upgrade'
  alias hd='helm delete'
fi
