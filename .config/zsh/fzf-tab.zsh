# ==============================================================
# ~/.config/zsh/fzf-tab.zsh
# fzf-tab 独立配置模块
# ==============================================================

# 1. 基础体验设置
zstyle ':completion:complete:*:options' sort false
zstyle ':completion:*' insert-tab false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'


# 2. 布局与主题 (Tokyo Night Day)
zstyle ':fzf-tab:*' fzf-flags '--color=fg:#3760bf,bg:#e1e2e7,hl:#9854f1,fg+:#3760bf,bg+:#b7c1e3,hl+:#f52a65,info:#587539,prompt:#2e7de9,pointer:#f52a65,marker:#587539,spinner:#007197,header:#848cb5'
zstyle ':fzf-tab:*' fzf-pad 4
zstyle ':fzf-tab:*' fzf-min-height 15

# 3. 实时预览引擎
# 【目录预览】
zstyle ':fzf-tab:complete:(cd|z|zi|ls|eza):*' fzf-preview 'eza --icons --color=always --tree --level=2 $realpath'

# 【文件预览】
zstyle ':fzf-tab:complete:(nvim|vim|vi|cat|bat|less):*' fzf-preview \
  'if [ -d $realpath ]; then eza --icons --color=always $realpath; else bat --color=always --style=numbers --line-range :500 $realpath 2>/dev/null || cat $realpath; fi'

# 【环境变量与别名预览】
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset):*' \
  fzf-preview 'echo ${(P)word}'

# 【进程预览】
#zstyle ':fzf-tab:complete:(kill|pkill):*' fzf-preview \
#  'if [[ $group == "[process ID]" ]]; then ps -p $word -o user,pid,ppid,%cpu,%mem,start,time,command; fi'
#zstyle ':fzf-tab:complete:(kill|pkill):*' fzf-flags --preview-window=down:30%:wrap

# 【Git 状态预览】
#zstyle ':fzf-tab:complete:git-(checkout|switch|diff|restore):*' fzf-preview \
#  'git log --oneline --graph --date=short --color=always $word 2>/dev/null || git diff --color=always $word 2>/dev/null'
