#!/bin/zsh
while true; do
  sleep 1h
  if ! pgrep -f "\bDiscord\b" &>/dev/null; then
    #Discord is closed so it's time to go.
    exit 1
  fi
  ./DAUT-check.sh
done