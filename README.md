# Personal dotfiles

### Installation
Prerequisites:
* `git`
* `make`
* RPM Fusion enabled manually before running `make`

Enable RPM Fusion first:
```
    sudo dnf install \
      https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
```

Optional:
```
    sudo dnf install \
      https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

Executing:
``` 
    git clone https://github.com/franc90/dotfiles.git
    cd dotfiles
    make
```
should do, but it's not tested regularly, so YMMV.

This repo is intended for Fedora Workstation and uses `dnf`.

Custom shortcuts:
- `Super+Return` launches Alacritty
- `Super+b` launches Firefox
- `Super+f` opens Nautilus in the home folder.

### A little bit of paranoia

* [privacytools](https://www.privacytools.io/)

### Moar
So that I don't waste time looking for it in the future.
* [awesome-dotfiles](https://github.com/webpro/awesome-dotfiles)
* [Luke Smith's voidrice](https://github.com/LukeSmithxyz/voidrice)
* [DT](https://gitlab.com/dwt1/dotfiles/)
* [rootbeersoup](https://github.com/rootbeersoup/dotfiles)
* [webpro](https://github.com/webpro/dotfiles)
* [thoughtbot](https://github.com/thoughtbot/dotfiles) 
