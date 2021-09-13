#!/bin/bash

# Sincronizar repositorios
sudo pacman -Syy

pacman -S efibootmgr linux-headers xdg-user-dirs xdg-utils

# Instalar driver de vídeo
pacman -S xf86-video-intel

# Instalar el entorno de escriorio
# Instalar los paquetes básicos
sudo pacman -S gdm gnome-shell gnome-control-center gnome-terminal nautilus
# Instalar el centro de software
sudo pacman -S gnome-software gnome-software-packagekit-plugin
# Instalar utilidades
sudo pacman -S gnome-calculator eog gnome-screenshot gnome-system-monitor
# Instalar paquetes opcionales
sudo pacman -S gnome-music gnome-calendar gnome-weather
# Instalar fuentes
sudo pacman -S otf-ipafont ttf-roboto ttf-fira-code ttc-iosevka

# Habilitar los servicios
sudo systemctl enable gdm
sudo systemctl enable NetworkManager

