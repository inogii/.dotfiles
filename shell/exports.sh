# Portable exports (sourced by both bash and zsh)
if command -v nvim >/dev/null 2>&1; then export EDITOR="nvim"; else export EDITOR="vi"; fi
export PATH="$HOME/.local/bin:$PATH"

[ -z "$LANG" ] && export LANG="C.UTF-8"

export KUBECONFIG="$HOME/.kube/config"
export DOCKER_BUILDKIT=1
