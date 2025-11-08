# ~/.dotfiles/bashrc

# Source core configs
for file in "$HOME/.dotfiles"/{exports,aliases,functions}.sh; do
    [ -f "$file" ] && source "$file"
done

# Completions
if [ -d "$HOME/.dotfiles/completions" ]; then
    for comp in "$HOME/.dotfiles/completions"/*; do
        [ -f "$comp" ] && source "$comp"
    done
fi

# Prompt
[ -f "$HOME/.dotfiles/prompt/bash_prompt.sh" ] && source "$HOME/.dotfiles/prompt/bash_prompt.sh"

# fzf integration if available
if command -v fzf >/dev/null 2>&1; then
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi
