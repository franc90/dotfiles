# Personal dotfiles

### Installation
Tried on Debian 10.

1. Do a minimal installation (only standard system utilities)
1. Generate dir structure for your user: `xdg-user-dirs-update`. It may require installing package `xdg-user-dirs`.
1. Swith to root `su -`
1. `apt install -y sudo git make vim`
1. `usermod -aG sudo {{username}}`
1. Use `visudo` and add line:  
    ```{{username}} ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot, /sbin/shutdown```
1. To all entries in `/etc/apt/sources.list` add `contrib non-free` 
1. In `/etc/apt/sources.list` append:
    ```
    deb http://deb.debian.org/debian buster-backports main contrib non-free
    deb-src http://deb.debian.org/debian buster-backports main contrib non-free
    ```
1. Run `apt update && apt upgrade`
1. Reboot
1. Execute:
    ```
    git clone https://github.com/franc90/dotfiles.git
    cd dotfiles
    git checkout debian
    make
    ```
1. Copy files in `etc` dir according to structure and instructions in repo.
1. Reboot

### A little bit of paranoia

I recommend going through [privacytools](https://www.privacytools.io/) and using whatever you deem appropriate.

### Moar
So that I don't waste time looking for it in the future.
* [awesome-dotfiles](https://github.com/webpro/awesome-dotfiles)
* [Luke Smith's voidrice](https://github.com/LukeSmithxyz/voidrice)
* [DT](https://gitlab.com/dwt1/dotfiles/)
* [rootbeersoup](https://github.com/rootbeersoup/dotfiles)
* [webpro](https://github.com/webpro/dotfiles)
* [thoughtbot](https://github.com/thoughtbot/dotfiles) 
