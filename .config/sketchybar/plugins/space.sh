#!/usr/bin/env bash

BLUE="${BLUE:-0xff2e7de9}"
TEXT="${TEXT:-0xff3760bf}"
MUTED="${MUTED:-0xff6172b0}"
SUBTLE="${SUBTLE:-0xff8990b3}"
TRANSPARENT="${TRANSPARENT:-0x00000000}"

# 从参数读取 SID，如果未传入则从 NAME 中截取
SID=$1
if [ -z "$SID" ]; then
  SID="${NAME##*.}"
fi

# 获取当前工作区窗口数量
WINDOW_COUNT="0"
if command -v aerospace >/dev/null 2>&1; then
  WINDOW_COUNT="$(aerospace list-windows --workspace "$SID" --count 2>/dev/null || echo 0)"
fi

# 如果 Aerospace 没有触发自定义事件传递 FOCUSED_WORKSPACE，我们主动获取一下
if [ -z "$FOCUSED_WORKSPACE" ]; then
  FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused 2>/dev/null)"
fi

# 检查当前 item 代表的工作区是否是 Aerospace 聚焦的工作区
if [ "$FOCUSED_WORKSPACE" = "$SID" ]; then
  sketchybar --set "$NAME" \
    drawing=on \
    background.drawing=on \
    background.color="$BLUE" \
    icon.color=0xffffffff \
    label.drawing=off
elif [ "$WINDOW_COUNT" -gt 0 ] 2>/dev/null; then
  sketchybar --set "$NAME" \
    drawing=on \
    background.drawing=off \
    background.color="$TRANSPARENT" \
    icon.color="$TEXT" \
    label.drawing=off
else
  sketchybar --set "$NAME" \
    drawing=off
fi
