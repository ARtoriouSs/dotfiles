#!/bin/bash

# this script should prepare a recently installed system to use

cd ~/dotfiles/bin # if ran from outside

cp ../system/temp_settings.sample.sh ../system/temp_settings.sh

./create_dir_tree.sh
./install_cli.sh
./install_gui.sh
./configure_system.sh
./install_rbenv.sh
./install_zsh.sh && source ~/.zprofile
./install_vim.sh
./create_symlinks.sh

git remote set-url origin git@github.com:$GITHUB_USERNAME/dotfiles.git # change remote link for this repo to use SSH

cd -

# reminder about manual/GUI configurations
echo
echo "Now you may need to perform some manual configuration:"
echo
echo "1) Reboot"
echo "2) Make terminal run login shell by default:"
echo "Edit -> Prefeneces -> Profiles -> Command -> Check 'run command as a login shell' option,"
echo "optionally add 'zsh -l' as a login command"
echo "3) Make terminal run maximized by default:"
echo "Edit -> Prefeneces -> Profiles -> Text -> Set default terminal size as 400 columns and 120 rows"
echo "4) Enable fonts in terminal:"
echo "Edit -> Preferences -> Profiles -> Text -> Custom font, search for Droid Sans Mono"
echo "5) Enable fractional scaling in GNOME on start up (if running on a huge screen):"
echo 'Settings -> Startup Applications -> Add `xrandr --output DP-4 --scale 1.5x1.5` (replace DP-4 with your monitor listed in `xrandr --listmonitors`)'
echo 'It can also be enabled via systemd service, see dotfiles/system/systemd/system/on_start_rescale_display.service'
echo "6) Reboot again :)"
echo
echo "Also you can manually run add_ssh.sh and enable_snap.sh when needed."
echo

exec zsh -l # relogin in the end
