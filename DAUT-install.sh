#!/bin/zsh
MYDIR="$(dirname "$0")"
VERSION="1.2"

if ! [[ -x "${MYDIR}/DAUT-start.sh" ]]; then
  chmod u+x "${MYDIR}/DAUT-start.sh"
fi
if ! [[ -x "${MYDIR}/DAUT-launch.sh" ]]; then
  chmod u+x "${MYDIR}/DAUT-launch.sh"
fi
if ! [[ -x "${MYDIR}/DAUT-loop.sh" ]]; then
  chmod u+x "${MYDIR}/DAUT-loop.sh"
fi
if ! [[ -x "${MYDIR}/DAUT-check.sh" ]]; then
  chmod u+x "${MYDIR}/DAUT-check.sh"
fi
if ! [[ -x "${MYDIR}/DAUT-update.sh" ]]; then
  chmod u+x "${MYDIR}/DAUT-update.sh"
fi

while true; do
  read "?Do you want to add .desktop entry for Discord Auto Update Thingie? [Y/n]" yn
  case $yn in
      [Yy]* ) break;;
      [Nn]* ) echo "Ok then.."; exit 0;;
      * ) break;;
  esac
done

printf '%s\n' '[Desktop Entry]' \
    "Version=${VERSION}" \
    'Type=Application' \
    "Name=Discord Auto Update Thingie" \
    'Comment=sloths script for keeping Discord up to date.' \
    'Icon=discord' \
    "Exec=${MYDIR}/DAUT-start.sh" \
    "Path=${MYDIR}" \
    'Terminal=true' \
    'Actions=' \
    'Categories=InstantMessaging;Network;' > $HOME/.local/share/applications/discord-auto-update-thingie.desktop

echo "Desktop entry added!"

while true; do
  read "?Disable default .desktop entry for Discord? [Y/n]" yn
  case $yn in
      [Yy]* ) break;;
      [Nn]* ) echo "Ok then.."; exit 0;;
      * ) break;;
  esac
done

DISCORDDESKTOPENTRY="/.local/share/applications/discord.desktop"

if [ -f "$HOME${DISCORDDESKTOPENTRY}" ]; then
  if [ $(cat "$HOME${DISCORDDESKTOPENTRY}" | grep NoDisplay) = "" ]; then
    echo "NoDisplay=true" >> "$HOME${DISCORDDESKTOPENTRY}"
  else
    sed -i 's/NoDisplay=.*/NoDisplay=true/' "$HOME${DISCORDDESKTOPENTRY}"
  fi
  echo "Done! You should be able to use Discord Auto Update Thingie now.."
  exit 0
else
  echo "Sorry, Could not locate the desktop entry for discord.."
  exit 1
fi
