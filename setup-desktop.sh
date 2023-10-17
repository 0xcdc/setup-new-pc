#install apps I use
flatpak install Spotify
flatpak install 'Signal Desktop'
flatpak install 'Whatsapp Desktop'

#fix alt tab to be between switch-window instead of switch-application
gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab', '<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward  "['<Alt><Shift>Tab', '<Super><Shift>Tab']"
