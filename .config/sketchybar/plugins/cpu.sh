#!/usr/bin/env bash

GREEN="${GREEN:-0xff587539}"
YELLOW="${YELLOW:-0xff8c6c3e}"
RED="${RED:-0xfff52a65}"

CPU="$(top -l 1 -n 0 | awk '/CPU usage/ {gsub("%", "", $3); gsub("%", "", $5); printf "%d", $3 + $5}')"
CPU="${CPU:-0}"

if [ "$CPU" -ge 80 ]; then
  COLOR="$RED"
elif [ "$CPU" -ge 50 ]; then
  COLOR="$YELLOW"
else
  COLOR="$GREEN"
fi

sketchybar --set "$NAME" \
  icon="" \
  icon.color="$COLOR" \
  label="${CPU}%"
