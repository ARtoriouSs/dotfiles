#!/bin/bash
set -o pipefail # a pipeline fails when any command in it fails, not only the last one

gh config set git_protocol ssh

### fonts
mkdir --parents ~/.local/share/fonts
curl -fLo ~/.local/share/fonts/DroidSansMNerdFont-Regular.otf https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf

fc-cache -f -v # update fonts cache

echo "Fonts were installed, enable it in terminal preferences:"
echo "Edit -> Preferences -> Text -> Custom font"
echo "Search for Droid Sans Mono"

### keyboard repeat delay and speed
# stored in dconf, so the desktop settings daemon applies them again after restart,
# wake up and keyboard reconnect, nothing has to run as root or on every boot
for schema in org.cinnamon.desktop.peripherals.keyboard org.gnome.desktop.peripherals.keyboard; do
  if gsettings list-schemas | grep -x "$schema" > /dev/null; then
    gsettings set "$schema" delay 190
    gsettings set "$schema" repeat-interval 23 # ms between repeats, about 43 per second
  fi
done

### display scaling for a big screen, link manually if needed (replace DP-0 with a monitor from `xrandr --listmonitors`):
# mkdir -p ~/.config/autostart && ln -sf ~/dotfiles/system/autostart/scale-up.desktop ~/.config/autostart/scale-up.desktop
