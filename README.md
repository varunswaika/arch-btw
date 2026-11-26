# arch-btw

> **Archived.** Superseded by [dotman](https://github.com/VarunAgarwalOfficial/dotman), which manages the same desktop setup from one colour system and templates. This repository is kept as a record and is read-only.

Shell scripts, dotfiles and a package list for setting up an Arch Linux desktop with Hyprland and a Catppuccin Mocha theme. `rice-setup/install.sh` installs `yay`, the packages in `rice-setup/pacman-packages.txt` and the drivers; the scripts in `rice-setup/install/` handle LazyVim, GRUB, GTK, icons, fonts, zsh, services and the dotfile links one step at a time. They call `sudo pacman`, `yay` and `systemctl` and write under `/etc`, so they change the system they run on.

## Licence

MIT, see LICENSE. The third-party themes kept here (the Catppuccin GRUB theme under `rice-setup/dotfiles/grub/`, and the bat, btop, ghostty and yazi themes) stay under their own upstream licences.
