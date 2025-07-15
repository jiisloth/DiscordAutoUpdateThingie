#!/bin/zsh

WORKDIR="$(pwd)"
MYDIR="$(dirname "$(realpath "$0")")"
URL=$1
CURRENT=$2
NEWEST=$3

echo "New discord version available! New: ${NEWEST} Current: ${CURRENT}"
if pgrep -f "\bDiscord\b" &>/dev/null; then
  echo "Discord is already running!"
  while true; do
    read "?Do you want to quit Discord and install update? [Y/n]" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit 1;;
        * ) break;;
    esac
  done
  echo "Quiting Discord"
  pkill -f "\bDiscord\b" &>/dev/null
  echo "Downloading new version..."
else
  while true; do
    read "?Do you want to download and install the new update? [Y/n]" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit 1;;
        * ) break;;
    esac
  done
fi

cd "${MYDIR}" || exit;
sudo echo ""
FILENAME="temp-$(basename "${URL}")"
curl "${URL}" -o "${FILENAME}"
echo "Installing!"
sudo dpkg -i "${FILENAME}"
rm "${FILENAME}"

sleep 3s
echo "Done! starting Discord!"
./DAUT-launch.sh &
sleep 3s

cd "${WORKDIR}" || exit;
exit 0;
