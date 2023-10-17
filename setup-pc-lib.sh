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

appendFileIfNotExists() {
  LINE=$1
  FILE=$2
  grep -qxF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
}

setupGit() {
  if [ ! -f $HOME/.gitconfig ]; then
    echo configuring git
    git config --global user.email "charliecarson@gmail.com"
    git config --global user.name "Charlie Carson"
    git config --global core.editor "vim"
    git config --global push.default simple
    git config pull.rebase true
else
    echo git already configured
  fi
}

setupVim() {
  if [ ! -f $HOME/.vimrc ]; then
    echo configuring vim
    cp .vimrc $HOME/.vimrc
  else
    echo vim already configured
  fi
}

setupNvm() {
  if [ -f $HOME/.nvm/nvm.sh ]; then
    echo nvm already installed
  else
    echo installing nvm

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

  fi
}


github_project() {
  for project in "$@"; do
    if [ ! -d $HOME/github/$project ]; then
      echo git cloning $project
      mkdir -p $HOME/github
      pushd $HOME/github
      git clone https://github.com/0xcdc/$project.git
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
