# XDG base directories.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Zsh Configuration Directory
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Default Editor (With Fallback)
if command -v nvim >/dev/null 2>&1; then
  export EDITOR="nvim"
  export VISUAL="nvim"
else
  export EDITOR="vim"
  export VISUAL="vim"
fi

# Path Deduplication & Setup
typeset -U path PATH

path=(
  /opt/homebrew/bin
  /opt/homebrew/sbin
  /usr/local/bin
  $HOME/.local/bin
  $path
)

# Local Override
[[ -f "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"

