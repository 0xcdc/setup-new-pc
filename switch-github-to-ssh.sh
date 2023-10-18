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
echo


function switchToSSH() {
  for project in "$@"; do
    if [ ! -d $HOME/github/$project ]; then
      echo git cloning $project
      mkdir -p $HOME/github
      cd $HOME/github
      git clone https://github.com/0xcdc/$project.git
      cd $project
      if [ -e package.json ]; then
        npm install
      fi
    else
      echo $project already exists
      cd $HOME/github/$project
      isHttp=`git remote -v | grep http`
      if [ ! "$isHttp" == "" ]; then
        echo switching $project to ssh
        git remote set-url origin git@github.com:0xcdc/$project.git
      else
        echo $project already using ssh
      fi
    fi
    echo
  done;
}

switchToSSH setup-new-pc rfb2-client-app rfb2-server
