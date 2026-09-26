#!/usr/bin/env bash

# If triggered by a system theme change, reload sketchybar to apply new colors globally
if [ "$SENDER" = "theme_change" ]; then
  sketchybar --reload
  exit 0
fi

# Get current macOS theme
CURRENT_THEME=$(osascript -e 'tell app "System Events" to tell appearance preferences to return dark mode')

if [ "$1" = "toggle" ]; then
  if [ "$CURRENT_THEME" = "true" ]; then
    # Switch to Light Mode
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false'
    CURRENT_THEME="false"
  else
    # Switch to Dark Mode
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
    CURRENT_THEME="true"
  fi
  # We don't need to manually reload here because changing the system theme 
  # will trigger AppleInterfaceThemeChangedNotification, which will run this 
  # script again with SENDER="theme_change" and reload sketchybar.
fi

# Set the icon based on the mode
if [ "$CURRENT_THEME" = "true" ]; then
  # Dark mode
  ICON="󰖔" # Moon icon for dark mode
  COLOR="0xffbb9af7" # LAVENDER (Night)
else
  # Light mode
  ICON="󰖨" # Sun icon for light mode
  COLOR="0xff8c6c3e" # YELLOW (Day)
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR"
