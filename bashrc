# --- Core dotfiles ---
for file in "$HOME/.dotfiles"/{exports,aliases,functions}.sh; do
  [ -f "$file" ] && source "$file"
done

# --- Prompt ---
[ -f "$HOME/.dotfiles/prompt/bash_prompt.sh" ] && source "$HOME/.dotfiles/prompt/bash_prompt.sh"

# --- Optional local overrides ---
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
