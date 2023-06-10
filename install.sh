#!/bin/bash

# TARDIS V2 (Taz's Automatic Ricing & Desktop Installation Script)
# I'm sooooo good at acronyms as you can tell
# Contact: taz@notnapoleon.net (EMAIL) or @notnapoleon:envs.net (MATRIX)

# VARIABLES
dir=$(pwd)
user=$(whoami)
aurhelper="yay"

aur_install() {
	echo "$aurinstalled" | grep -q "^$1$" && return 1
	sudo -u "$name" $aurhelper -S --noconfirm "$1" >/dev/null 2>&1
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

# Run OhMyZsh script (not written by me)

zsh_configure() {
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# The actual script (very barebones as you can tell)

aur_install yay && aur_packages
add_repos
pacman_packages && systemd_services
dotfiles_configure
zsh_configure
clear ; echo "Installation complete. Please restart your computer."
