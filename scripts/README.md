# Scripts

Installation scripts must be executed with sudo.

## Explanations

- [prepare.sh](prepare.sh) - prepares recently installed system. It will also execute all other scripts here. Don't run it if you don't need everithing.
- [create_symlinks.sh](create_symlinks.sh) - Adds symlinks for all dotfiles in this repo so they can store in one place.
- [install_cli.sh](install_cli.sh) - Installs cli programmes.
- [configure_system.sh](configure_system.sh) - Sets up some system settings.
- [add_ssh.sh](add_ssh.sh) - Generates ssh key and adds it to ssh-agent. Takes email as first argument.
- [enable_snap.sh](enable_snap.sh) - Reenables snap for new Linux Mint if needed.

Other scripts install appropriate software and described in other READMEs
