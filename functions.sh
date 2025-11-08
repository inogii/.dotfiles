# SSH with dotfiles bootstrap
sshf() {
  ssh -A "$1" "if [ ! -d ~/.dotfiles ]; then \
      git clone --depth=1 git@github.com:inogii/dotfiles.git ~/.dotfiles; \
      ln -sf ~/.dotfiles/bashrc ~/.bashrc; \
  fi; exec bash --login"
}

# Quickly exec into first pod that matches name
kexec() {
  pod=$(kubectl get pods --no-headers | grep "$1" | head -n1 | awk '{print $1}')
  [ -z "$pod" ] && echo "No pod found" && return 1
  kubectl exec -it "$pod" -- bash
}

# Tail logs of first matching pod
ktail() {
  pod=$(kubectl get pods --no-headers | grep "$1" | head -n1 | awk '{print $1}')
  kubectl logs -f "$pod"
}

# Sync dotfiles to remote host
dotpush() {
  rsync -avz --delete ~/.dotfiles "$1":~/
}
