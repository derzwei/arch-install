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
echo Contraseña para el usuario root: 
read rootPass
echo root:$rootPass | chpasswd
echo Nuevo usuario: 
read userName
useradd -mG wheel $userName
echo Contraseña para el nuevo usuario: 
read userPass
passwd $userName

pacman -Syy

pacman -S --noconfirm efibootmgr xdg-user-dirs xdg-utils xf86-video-intel

pacman -S --noconfirm gdm gnome-shell gnome-control-center gnome-tweaks gnome-terminal nautilus gnome-software gnome-software-packagekit-plugin

pacman -S --noconfirm gnome-calculator foliate eog gnome-music gnome-calendar gnome-weather gnome-screenshot gnome-system-monitor

pacman -S --noconfirm ttf-fira-sans ttf-fira-code otf-ipafont

sed -i 's/MODULES=()/MODULES=(i915)/' /etc/mkinitcpio.conf
mkinitcpio -p linux

bootctl install
sed -i 's/#timeout 3/timeout 5/' /boot/loader/loader.conf
sed -i 's/#console-mode keep/console-mode max/' /boot/loader/loader.conf
sed -i 's/default.*/default arch.conf/' /boot/loader/loader.conf
echo "title	Arch Linux" >> /boot/loader/entries/arch.conf
echo "linux	/vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd	/intel-ucode.img" >> /boot/loader/entries/arch.conf
echo "initrd	/initramfs-linux.img" >> /boot/loader/entries/arch.conf
echo 'options	root="LABEL=arch" rw' >> /boot/loader/entries/arch.conf

systemctl enable gdm
systemctl enable NetworkManager
timedatectl set-ntp true

sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 4/g' /etc/pacman.conf
sed -i 's/#Color/Color/g' /etc/pacman.conf
