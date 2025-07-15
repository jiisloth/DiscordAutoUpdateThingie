#!/bin/zsh
CURRENT_VER="$(dpkg -s discord | grep '^Version:' | sed -n 's/.*Version: \([^"]*\).*/\1/p')"
NEWEST_URL="$(curl 'https://discord.com/api/download?platform=linux' -s | sed -n 's/.*href="\([^"]*\).*/\1/p')"

if [ "${NEWEST_URL}" = "" ]; then
  #Probably no internet..
  exit 1
fi
NEWEST_VER="$(echo "${NEWEST_URL}" | sed -n 's/.*linux\/\([^"]*\)\/discord.*/\1\n/p')"

if [ "${NEWEST_VER}" = "${CURRENT_VER}" ]; then
  #No updates..
  exit 0
else
  while true; do
    ACTIVEWINDOW="$(xprop -id "$(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f 5)" WM_NAME | sed -e 's/.* \(.*\)".*/\1/')"
    if [ "${ACTIVEWINDOW}" = "Discord" ]; then
      break
    fi
    if ! pgrep -f "\bDiscord\b" &>/dev/null; then
      exit 1
    fi
    sleep 10s
  done
  gnome-terminal -- ./DAUT-update.sh ${NEWEST_URL} ${CURRENT_VER} ${NEWEST_VER}
  while true; do
    sleep 5s
    if ! pgrep -f DAUT-update.sh &>/dev/null; then
      break
    fi
  done
fi
exit 0