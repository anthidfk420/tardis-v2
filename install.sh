#!/bin/bash

# TARDIS V2 (Taz's Automatic Ricing & Desktop Installation Script)
# I'm sooooo good at acronyms as you can tell
# Contact: taz@notnapoleon.net (EMAIL) or @notnapoleon:envs.net (MATRIX)

# VARIABLES
dir=$(pwd)
user=$(whoami)

aur_install() {
	sudo pacman -S --needed git base-devel --noconfirm && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm
}

add_repos() {
	sudo echo "[multilib]" >> /etc/pacman.conf 
	sudo echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
}

pacman_packages() {
	sudo pacman -S i3 polybar rofi dunst thunar ranger nitrogen neofetch htop gthumb alacritty zsh mpv gnu-free-fonts vim leafpad noto-fonts noto-fonts-cjk noto-fonts-emoji gvfs-smb gnome-screenshot curl wget sddm pavucontrol pop-gtk-theme cups thunderbird --noconfirm 
}

aur_packages() {
	yay -S hollywood mint-y-icons peazip-gtk2-bin cava librewolf-bin librewolf-extension-dark-reader --noconfirm
}

systemd_services() {
	sudo systemctl enable sddm.service
	sudo systemctl enable cups.service
}

dotfiles_configure() {
	mkdir ~/.config
	cp -r $dir/dotfiles/gtk-3.0 ~/.config
	cp -r $dir/dotfiles/i3 ~/.config
	cp -r $dir/dotfiles/nitrogen ~/.config
	cp -r $dir/dotfiles/polybar ~/.config
	cp -r $dir/dotfiles/rofi ~/.config
	cp -r $dir/dotfiles/alacritty ~/.config
	cp -r $dir/dotfiles/dunst ~/.config
	cp -r $dir/dotfiles/sfx ~/.config
	cp -r ~/.config/rofi/custom_theme/nasa-red.rasi /usr/share/rofi/themes/
	sudo cp -r $dir/dotfiles/wallpapers /usr/share/
}

# The actual script (very barebones as you can tell)

aur_install && add_repos && aur_packages
pacman_packages && systemd_services
dotfiles_configure
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
clear ; echo "Installation complete. Please restart your computer."
