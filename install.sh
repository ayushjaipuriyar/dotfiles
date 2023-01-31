#!/bin/bash

sudo pacman-mirrors --fasttrack

sudo pacman -Syy

sudo nano /etc/pacman.conf

sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

sudo nano /etc/paru.conf

paru -S $(cat pkglist)

curl -sS https://starship.rs/install.sh | sh

## sudo visudo
sudo -i
cat >>/etc/sudoers <<<'ayush ALL=(ALL:ALL) NOPASSWD: /usr/bin/vantage'
cat >>/etc/sudoers <<<'ayush ALL=(ALL:ALL) NOPASSWD: /usr/bin/ryzenadj'
