# Install on Debian
Checked for Debian 10.

1. Do minimal installation (only standard system utilities)
1. Swith to root `su -`
1. `apt install -y sudo git make vim`
1. `usermod -aG sudo {{username}}`
1. By `visudo` add line:  
    ```{{username}} ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot, /sbin/shutdown```
1. To all entries in `/etc/apt/sources.list` add `contrib non-free` 
1. Append to `/etc/apt/sources.list`:
    ```
    deb http://deb.debian.org/debian buster-backports main contrib non-free
    deb-src http://deb.debian.org/debian buster-backports main contrib non-free
    ```
1. `apt update && apt upgrade`
1. Reboot
1. Execute:
    ```
    git clone https://github.com/franc90/dotfiles.git
    cd dotfiles
    git checkout debian
    make
    ```
1. Reboot