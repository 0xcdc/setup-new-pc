apt_install() {
    # Avoid marking installed packages as manual by only installing missing ones
    local pkg=
    local pkgs=()
    local ok
    for pkg in "$@"; do
        # shellcheck disable=SC1083
        echo "checking $pkg"
        ok=$(dpkg-query --showformat=\${Version} --show "$pkg" 2>/dev/null || true)
        if [[ -z "$ok" ]]; then pkgs+=( "$pkg" ); fi
    done
    if (("${#pkgs[@]}")); then
        echo installing "${pkgs[@]}"
        sudo apt install -qq "${pkgs[@]}"
    fi
}

apt_install curl git vim vim-gui-common vim-gtk3 xclip

appendFileIfNotExists() {
  LINE=$1
  FILE=$2
  grep -qxF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
}


appendFileIfNotExists 'set -o vi' "$HOME/.bashrc"

if [ ! -f $HOME/.gitconfig ]; then
  echo configuring git
  curl -s https://raw.githubusercontent.com/0xcdc/vimrc/master/setup-git.sh | bash
else
  echo git already configured
fi

if [ ! -f $HOME/.vimrc ]; then
  echo configuring vim
  curl -s https://raw.githubusercontent.com/0xcdc/vimrc/master/.vimrc > $HOME/.vimrc
else
  echo vim already configured
fi

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

if [ -f $HOME/.nvm/nvm.sh ]; then
  echo nvm already installed
else
  echo installing nvm

  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

fi

export NVM_DIR=$HOME/.nvm;
source $NVM_DIR/nvm.sh;

nvm install --lts
appendFileIfNotExists 'nvm use --lts' "$HOME/.bashrc"

mkdir -p $HOME/github

github_project() {
  for project in "$@"; do
    if [ ! -d $HOME/github/$project ]; then
      echo git cloning $project
      pushd $HOME/github
      git clone -q git@github.com:0xcdc/$project.git
      cd $project
      if [ -e package.json ]; then
        npm install
      fi
      popd
    else
      echo $project already exists
    fi
  done;
}

github_project rfb2-server rfb2-client-app setup-new-pc


echo '
source $HOME/.bashrc
' | xclip -sel clip
echo please past and run the buffer to reload bashrc
