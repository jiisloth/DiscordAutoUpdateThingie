#!/bin/zsh
WORKDIR="$(pwd)"
MYDIR="$(dirname "$0")"

cd "${MYDIR}" || exit 1;
# go to script main folder

DISCORDPID="$(pgrep -f "\bDiscord\b")"
if [ "${DISCORDPID}" = "" ]; then
  # Discord is not running, check for update before launching.
  ./DAUT-check.sh force
  ./DAUT-launch.sh &
else
  # Discord is running, use launch.sh to switch window and check for update afterwards..
  ./DAUT-launch.sh &
  ./DAUT-check.sh force &
fi

AUTOUPDATERPID="$(pgrep -f DAUT-loop.sh)"
if [ "${AUTOUPDATERPID}" = "" ]; then
  # Launch the loop if its not running.
  nohup ./DAUT-loop.sh >/dev/null 2>&1 &
fi

cd "${WORKDIR}" || exit 1;
exit 0;
