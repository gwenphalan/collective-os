#!/bin/bash

# Set install mode to online since boot.sh is used for curl installations
export COLLECTIVEOS_ONLINE_INSTALL=true

ansi_art='                 ▄▄▄                                                   
 ▄█████▄    ▄███████████▄    ▄███████   ▄███████   ▄███████   ▄█   █▄    ▄█   █▄ 
███   ███  ███   ███   ███  ███   ███  ███   ███  ███   ███  ███   ███  ███   ███
███   ███  ███   ███   ███  ███   ███  ███   ███  ███   █▀   ███   ███  ███   ███
███   ███  ███   ███   ███ ▄███▄▄▄███ ▄███▄▄▄██▀  ███       ▄███▄▄▄███▄ ███▄▄▄███
███   ███  ███   ███   ███ ▀███▀▀▀███ ▀███▀▀▀▀    ███      ▀▀███▀▀▀███  ▀▀▀▀▀▀███
███   ███  ███   ███   ███  ███   ███ ██████████  ███   █▄   ███   ███  ▄██   ███
███   ███  ███   ███   ███  ███   ███  ███   ███  ███   ███  ███   ███  ███   ███
 ▀█████▀    ▀█   ███   █▀   ███   █▀   ███   ███  ███████▀   ███   █▀    ▀█████▀ 
                                       ███   █▀                                  '

clear
echo -e "\n$ansi_art\n"

sudo pacman -Syu --noconfirm --needed git

# Use custom repo if specified, otherwise default to basecamp/collectiveos
COLLECTIVEOS_REPO="${COLLECTIVEOS_REPO:-basecamp/collectiveos}"

echo -e "\nCloning CollectiveOS from: https://github.com/${COLLECTIVEOS_REPO}.git"
rm -rf ~/.local/share/collectiveos/
git clone "https://github.com/${COLLECTIVEOS_REPO}.git" ~/.local/share/collectiveos >/dev/null

# Use custom branch if instructed, otherwise default to master
COLLECTIVEOS_REF="${COLLECTIVEOS_REF:-master}"
if [[ $COLLECTIVEOS_REF != "master" ]]; then
  echo -e "\e[32mUsing branch: $COLLECTIVEOS_REF\e[0m"
  cd ~/.local/share/collectiveos
  git fetch origin "${COLLECTIVEOS_REF}" && git checkout "${COLLECTIVEOS_REF}"
  cd -
fi

echo -e "\nInstallation starting..."
source ~/.local/share/collectiveos/install.sh
