#!/usr/bin/env bash

GREEN="${GREEN:-0xff587539}"
YELLOW="${YELLOW:-0xff8c6c3e}"
RED="${RED:-0xfff52a65}"

PAGE_SIZE="$(vm_stat | awk '/page size of/ {gsub("\\.", "", $8); print $8}')"
TOTAL_BYTES="$(sysctl -n hw.memsize)"

pages() {
  vm_stat | awk -v key="$1" '$0 ~ key {gsub("\\.", "", $NF); print $NF; exit}'
}

ACTIVE="$(pages '^Pages active:')"
WIRED="$(pages '^Pages wired down:')"
COMPRESSED="$(pages '^Pages occupied by compressor:')"

USED_PAGES=$(( ${ACTIVE:-0} + ${WIRED:-0} + ${COMPRESSED:-0} ))
USED=$(( USED_PAGES * PAGE_SIZE * 100 / TOTAL_BYTES ))

if [ "$USED" -ge 80 ]; then
  COLOR="$RED"
elif [ "$USED" -ge 50 ]; then
  COLOR="$YELLOW"
else
  COLOR="$GREEN"
fi

sketchybar --set "$NAME" \
  icon="" \
  icon.color="$COLOR" \
  label="${USED}%"
