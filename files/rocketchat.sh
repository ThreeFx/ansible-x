#!/bin/bash

set -e

VERS="2.8.0"
TMP_DIR="rocket_$(date +%s)"
DEPLOY_PATH="/opt/Rocket.Chat+"

if [[ $EUID -ne 0 ]]; then
  echo -e "\e[0;35m This script must be run as root \e[0m" 1>&2
  exit 1
fi

mkdir -p /tmp/${TMP_DIR}
cd /tmp/${TMP_DIR}

wget https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/${VERS}/rocketchat_${VERS}_amd64.deb

ar x rocketchat_${VERS}_amd64.deb
tar xvf data.tar.xz
tar xzvf control.tar.gz

md5sum -c md5sums

rm -fv $DEPLOY_PATH
mv -v opt/Rocket.Chat+ $DEPLOY_PATH

ln -svf "${DEPLOY_PATH}/rocketchat" '/usr/local/bin/rocketchat'
