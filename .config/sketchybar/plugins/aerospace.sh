#!/usr/bin/env bash

# === 防抖逻辑 (Debounce) ===
# 如果有旧进程还在等待，则直接 kill 掉
PIDFILE="/tmp/sketchybar_aerospace.pid"
if [ -f "$PIDFILE" ]; then
  kill -9 $(cat "$PIDFILE") 2>/dev/null || true
fi
# 把当前进程的 PID 写入文件
echo $$ > "$PIDFILE"

# 延迟 50 毫秒。如果在这 50ms 内有新的事件触发，本进程会被上面的 kill 杀掉，从而放弃执行
sleep 0.05

BLUE="${BLUE:-0xff2e7de9}"
TEXT="${TEXT:-0xff3760bf}"
MUTED="${MUTED:-0xff6172b0}"
SUBTLE="${SUBTLE:-0xff8990b3}"
TRANSPARENT="${TRANSPARENT:-0x00000000}"

# 1. 尝试使用环境变量 FOCUSED_WORKSPACE，如果没有则主动获取
if [ -z "$FOCUSED_WORKSPACE" ]; then
  FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused 2>/dev/null)"
fi

# 2. 一次性获取所有有窗口的工作区编号
# aerospace list-windows --all --format "%{workspace}" 
# 返回类似:
# 1
# 1
# 3
# 使用 sort -u 去重后得到有窗口的列表
HAS_WINDOWS=$(aerospace list-windows --all --format "%{workspace}" 2>/dev/null | sort -u)

args=()

# 3. 遍历所有的 workspace (1..6)
for sid in {1..6}; do
  if [ "$FOCUSED_WORKSPACE" = "$sid" ]; then
    # 聚焦的工作区
    args+=(--set space.$sid drawing=on background.drawing=on background.color="$BLUE" icon.color=0xffffffff label.drawing=off)
  elif echo "$HAS_WINDOWS" | grep -q "^$sid$"; then
    # 有窗口但未聚焦的工作区
    args+=(--set space.$sid drawing=on background.drawing=off background.color="$TRANSPARENT" icon.color="$TEXT" label.drawing=off)
  else
    # 没有窗口且未聚焦的工作区
    args+=(--set space.$sid drawing=off)
  fi
done

# 4. 一次性将所有参数交给 sketchybar 执行
sketchybar -m "${args[@]}"
