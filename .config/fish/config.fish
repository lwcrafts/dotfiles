set fish_greeting ""

fish_add_path /bin
fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
fish_add_path /opt/homebrew/bin

# Fish Vi mode
set -g fish_key_bindings fish_vi_key_bindings

# pyenv
set -Ux PYENV_ROOT $HOME/.pyenv
test -d $PYENV_ROOT/bin; and fish_add_path $PYENV_ROOT/bin

set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx EDITOR nvim
set -gx XDG_RUNTIME_DIR ~/.runtime
set -gx XDG_CONFIG_HOME $HOME/.config

alias config '/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias reload 'source $XDG_CONFIG_HOME/fish/config.fish'
alias ls 'eza --color=always --icons --group-directories-first'
alias la 'eza --color=always --icons --group-directories-first --all'
alias ll 'eza --color=always --icons --group-directories-first --all --long'
# mihomo
alias mihomo-start 'sudo launchctl load -w /Library/LaunchDaemons/com.mihomo.plist'
alias mihomo-stop 'sudo launchctl unload -w /Library/LaunchDaemons/com.mihomo.plist'
alias mihomo-restart 'sudo launchctl unload -w /Library/LaunchDaemons/com.mihomo.plist && sudo launchctl load -w /Library/LaunchDaemons/com.mihomo.plist'
alias mihomo-status 'sudo launchctl list | grep mihomo'

abbr tm task-master
abbr t tmux
abbr ta 'tmux attach -t'
abbr tc 'tmux attach'
abbr tl 'tmux ls'
abbr ts 'tmux new -s'
abbr tk 'tmux kill-session -t'
abbr mv "mv -iv"
abbr cp "cp -riv"
abbr mkdir "mkdir -vp"
abbr l ll
abbr vim nvim
#alias lazygit "TERM=xterm-256color command lazygit"
abbr gg lazygit
abbr cls clear

# cargo
if test -f $HOME/.cargo/env.fish
  source $HOME/.cargo/env.fish
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pnpm
set -gx PNPM_HOME /Users/devling/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# fzf
if type -q fzf
  fzf --fish | source
end

# zoxide
if type -q zoxide
  zoxide init fish | source
end

# fnm
if type -q fnm
  fnm env | source
end

# oh-my-posh
# if type -q oh-my-posh
#   oh-my-posh init fish --config $XDG_CONFIG_HOME/ohmyposh/config.omp.json | source
# end

if type -q starship
  starship init fish | source
end

# local config
set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end
