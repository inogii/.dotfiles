# --- Create and enter a directory ---
mkcd() { mkdir -p "$1" && cd "$1" || return; }

# --- Quick IP check ---
myip() { curl -s ifconfig.me 2>/dev/null || echo "offline"; }

# --- Reload shell without restart ---
reload() { source ~/.bashrc; echo "🔁 Reloaded .bashrc"; }

# --- Exec into first matching pod ---
kexec() {
  command -v kubectl >/dev/null 2>&1 || { echo "kubectl not found"; return 1; }
  pod=$(kubectl get pods --no-headers 2>/dev/null | grep "$1" | head -n1 | awk '{print $1}')
  [ -z "$pod" ] && { echo "No pod found matching $1"; return 1; }
  kubectl exec -it "$pod" -- bash
}

# --- Tail logs of first matching pod ---
ktail() {
  command -v kubectl >/dev/null 2>&1 || { echo "kubectl not found"; return 1; }
  pod=$(kubectl get pods --no-headers 2>/dev/null | grep "$1" | head -n1 | awk '{print $1}')
  [ -z "$pod" ] && { echo "No pod found matching $1"; return 1; }
  kubectl logs -f "$pod"
}
