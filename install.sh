#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
sed -i '' /etc/pacman.conf
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=la-latin1" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo Contraseña para el usuario root: 
read passvar
echo root:$passvar | chpasswd

pacman -Syy
pacman -S --noconfirm efibootmgr xdg-user-dirs xdg-utils xf86-video-intel

pacman -S --noconfirm gdm gnome-shell gnome-control-center gnome-tweaks gnome-terminal nautilus gnome-software gnome-software-packagekit-plugin

pacman -S --noconfirm gnome-calculator foliate eog gnome-music gnome-calendar gnome-weather gnome-screenshot gnome-system-monitor

pacman -S --noconfirm ttf-fira-sans ttf-fira-code otf-ipafont

systemctl enable gdm
systemctl enable NetworkManager
timedatectl set-ntp true

sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 4/g' /etc/pacman.conf
sed -i 's/#Color/Color/g' /etc/pacman.conf
