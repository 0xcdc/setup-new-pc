#!/usr/bin/bash
source setup-pc-lib.sh

apt_install curl git mysql-server vim vim-gtk3 vim-gui-common xclip virtualbox
appendFileIfNotExists 'set -o vi' "$HOME/.bashrc"
setupGit
setupVim
setupNvm

export NVM_DIR=$HOME/.nvm;
source $NVM_DIR/nvm.sh;

nvm install --lts
appendFileIfNotExists 'nvm use --lts' "$HOME/.bashrc"

github_project rfb2-server rfb2-client-app

echo '
source $HOME/.bashrc
' | xclip -sel clip
echo please past and run the buffer to reload bashrc
