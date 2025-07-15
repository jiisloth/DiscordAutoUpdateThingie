#!/bin/zsh
if pgrep -f "\bDiscord\b" &>/dev/null; then
  # Already running. select window.
  if ! wmctrl -a '- Discord'; then
    if ! wmctrl -a 'Discord'; then
      # Could not select the window so just try starting discord.
      # Might bring the window to top or not..
      nohup discord > /dev/null 2>&1 &
    fi
  fi
else
  # Discord not on. launching it now.
  echo "Starting discord!"
  nohup discord > /dev/null 2>&1 &
fi
exit 0;