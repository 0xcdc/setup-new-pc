shell_count=`ls /dev/pts/ | wc -l`
shell_count=$(($shell_count - 1))

if [ "$shell_count" -eq 1 ]; then
  cd ~/github/rfb2-server
  cd ~/github/rfb2-client-app

  gnome-terminal --full-screen --tab
  npm run start
elif [ "$shell_count" -eq 2 ]; then
  cd ~/github/rfb2-server

  gnome-terminal --tab
  npm run debug-start
elif [ "$shell_count" -eq 3 ]; then
  gnome-terminal --tab
fi

