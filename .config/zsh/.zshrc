ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# 自动创建缓存目录
[[ -d "$XDG_CACHE_HOME/zsh" ]] || mkdir -p "$XDG_CACHE_HOME/zsh"

# 补全系统
autoload -Uz compinit
if [[ -n "$XDG_CACHE_HOME/zsh/.zcompdump"(N.mh+24) ]]; then
  compinit -d "$XDG_CACHE_HOME/zsh/.zcompdump"
else
  compinit -C -d "$XDG_CACHE_HOME/zsh/.zcompdump"
fi

# zsh-completions
zinit light zsh-users/zsh-completions

# zsh-vi-mode
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# zsh-autosuggestions
zinit ice wait"0" atload"_zsh_autosuggest_start" lucid
zinit light zsh-users/zsh-autosuggestions

# zsh-syntax-highlighting
zinit ice wait"0" lucid
zinit light zsh-users/zsh-syntax-highlighting

# fzf-tab
zinit light Aloxaf/fzf-tab

# oh my posh
eval "$(oh-my-posh init zsh --config $XDG_CONFIG_HOME/ohmyposh/config.omp.json)"

# zoxide
eval "$(zoxide init zsh)"


[[ -f "$ZDOTDIR/fzf-tab.zsh" ]] && source "$ZDOTDIR/fzf-tab.zsh"
[[ -f "$ZDOTDIR/aliases.zsh" ]] && source "$ZDOTDIR/aliases.zsh"
[[ -f "$ZDOTDIR/proxy.zsh" ]] && source "$ZDOTDIR/proxy.zsh"

[[ -f "$ZDOTDIR/.zshrc.local" ]] && source "$ZDOTDIR/.zshrc.local"
