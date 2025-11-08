# Kubernetes
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kl='kubectl logs -f'
alias kctx='kubectl config use-context'
alias kns='kubectl config set-context --current --namespace'

# Docker
alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'

# Helm
alias h='helm'
alias hl='helm list --all-namespaces'
alias hs='helm status'

# Git
alias g='git'
alias gs='git status'
alias gl='git log --oneline --graph --decorate -10'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# Quality-of-life
alias ll='ls -lh --color=auto'
alias la='ls -lah --color=auto'
alias please='sudo $(fc -ln -1)'
