#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=la-latin1" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd

# Actualizar base de datos
pacman -Syy
# Instalar paquetes base
pacman -S efibootmgr linux-headers xdg-user-dirs xdg-utils xf86-video-intel

# Instalar GNOME
pacman -S gdm gnome-shell gnome-control-center gnome-terminal nautilus
# Tienda
pacman -S gnome-software gnome-software-packagekit-plugin
# Utilidades
sudo pacman -S gnome-text-editor gnome-calculator eog gnome-screenshot gnome-system-monitor
# Opcional
sudo pacman -S gnome-music gnome-calendar gnome-weather
# Fuentes
sudo pacman -S ttf-fira-sans ttf-fira-code ttc-iosevka otf-ipafont

# Habilitar los servicios
sudo systemctl enable gdm
sudo systemctl enable NetworkManager
