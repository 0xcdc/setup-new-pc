#!/usr/bin/bash

if [ ! -f $HOME/.ssh/id_rsa ]; then
  echo setting up ssh
  ssh-keygen -t rsa -b 4096 -C "charliecarson@gmail.com"
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
  xclip -sel clip < ~/.ssh/id_rsa.pub
  echo paste your ssh key into github profile and press return when you are finished
  read cont
else
  echo ssh already set up
fi
