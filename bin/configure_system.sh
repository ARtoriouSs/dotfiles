#!/bin/bash

gh config set git_protocol ssh

### fonts
cd ~/.local/share/fonts/
sudo curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf

fc-cache -f -v # update fonts cache
cd -

echo "Fonts were installed, enable it in terminal preferences:"
echo "Edit -> Preferences -> Text -> Custom font"
echo "Search for Droid Sans Mono"

### systemd links
# on start
sudo ln -sf ~/dotfiles/system/systemd/system/on_start.service /etc/systemd/system/on_start.service
sudo ln -sf ~/dotfiles/system/systemd/system/on_start_rescale_display.service /etc/systemd/system/on_start_rescale_display.service
sudo ln -sf ~/dotfiles/system/systemd/bin/on_start.sh /usr/local/bin/on_start.sh

# Run manually if needed: `sudo systemctl enable on_start_rescale_display.service`
sudo systemctl enable on_start.service

# on wake up
sudo ln -sf ~/dotfiles/system/systemd/system-sleep/on_wake_up.sh /lib/systemd/system-sleep/on_wake_up.sh
# Run manually if needed: `sudo ln -sf ~/dotfiles/system/systemd/system-sleep/on_wake_up_rescale_display.sh /lib/systemd/system-sleep/on_wake_up_rescale_display.sh`
