## Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==========================================
# History Configuration
# ==========================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ==========================================
# Keybindings (History Search)
# ==========================================
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# ==========================================
# Arch Linux System Plugins & Theme
# ==========================================
# Powerlevel10k Theme (Arch package path)
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Autosuggestions & Syntax Highlighting (Arch package paths)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ==========================================
# FZF Configuration
# ==========================================
# Default command using fd
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Custom theme matching Josean's aesthetic & your Ghostty palette
export FZF_DEFAULT_OPTS=" \
--color=bg+:#033259,bg:#00111E,spinner:#24EAF7,hl:#FFE073 \
--color=fg:#CBE0F0,header:#FFE073,info:#a277ff,pointer:#44FFB1 \
--color=marker:#44FFB1,fg+:#CBE0F0,prompt:#0FC5ED,hl+:#FFE073"

# Preview command helper
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source <(fzf --zsh)

# fzf-git integration (if cloned to ~/fzf-git.sh)
if [ -f ~/fzf-git.sh/fzf-git.sh ]; then
  source ~/fzf-git.sh/fzf-git.sh
fi

# ==========================================
# Tool Integrations (zoxide, thefuck, yazi)
# ==========================================
# Initialize zoxide (smart cd replacement)
eval "$(zoxide init zsh)"

# Initialize thefuck
eval $(thefuck --alias)

# Yazi wrapper to auto-cd on exit
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# ==========================================
# Aliases
# ==========================================
alias c="clear"
alias cd="z"

# eza replacements for ls
alias ls="eza --icons=always"
alias ll="eza -lah --icons=always"
alias la="eza -a --icons=always"
alias lt="eza --tree --level=2 --icons=always"

# bat replacement for cat
alias cat="bat --paging=never"

# Neovim
alias v="nvim"
alias vi="nvim"
alias vim="nvim"

# ==========================================
# User Paths
# ==========================================
export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.spicetify" ]] && export PATH="$PATH:$HOME/.spicetify" Created by newuser for 5.9.2
