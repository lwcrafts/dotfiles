#!/bin/bash

# 将这里替换为你第一步查到的真实内屏 UUID
MBP_UUID="37D8832A-2D66-02CA-B9F7-8F30A301B230"
BASE_TOP_PADDING=48
MBP_TOP_PADDING=18

# 1. 先将全局设置为外接屏幕的默认值 48
yabai -m config top_padding $BASE_TOP_PADDING

# 2. 便利当前所有的显示器
yabai -m query --displays | jq -c '.[]' | while read -r display; do
  display_uuid=$(echo "$display" | jq -r '.uuid')
  # 获取这个显示器上拥有的所有 Space 编号
  spaces=$(echo "$display" | jq -r '.spaces[]')

  # 3. 核心判断：如果是内屏
  if [[ "$display_uuid" == "$MBP_UUID" ]]; then
    for space in $spaces; do
      yabai -m config --space "$space" top_padding $MBP_TOP_PADDING
    done
  else
    for space in $spaces; do
      yabai -m config --space "$space" top_padding $BASE_TOP_PADDING
    done
  fi
done
