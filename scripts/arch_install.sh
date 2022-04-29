#!/bin/bash

echo -ne "\nEnter the step No : "
read p

case $p in
  1)
    timedatectl set-ntp true
    timedatectl status
    clear
    
    ping archlinux.org
    
    lsblk                            
    lsblk -f

    echo -ne "\nSelect a drive to partition (eg: sdc) and create a efi and root partitions : "
    read x
    cfdisk -z /dev/$x
    clear

    lsblk
    lsblk -f
    echo -ne "\nEnter the Partition to be formated as root(eg: sdc1) : "
    read y
    echo -ne "\nEnter the Partition to be formated as efi(eg: sdc1) : "
    read x
    mkfs.ext4 /dev/$y
    mkfs.fat -F32 /dev/$x
    clear
    mount /dev/$y /mnt
    mkdir /mnt/efi
    mount /dev/$x /mnt/efi

    pacstrap /mnt base linux linux-firmware

    genfstab -U /mnt >> /mnt/etc/fstab

    cp /arch_install.sh /mnt/
    arch-chroot /mnt
    ;;

  2)
    ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
    hwclock --systohc
    pacman -Syyu netctl dialog dhcpcd wpa_supplicant ifplugd netctl git grub efibootmgr os-prober neofetch vi sudo neovim nnn stow

    echo -ne "\nEdit /etc/locale.gen\n"
    nvim /etc/locale.gen
    echo "LANG=en_US.UTF-8" > /etc/locale.conf
    clear
    
    echo -ne "\nEdit /etc/hosts\n"
    nvim /etc/hosts
    clear

    useradd -G wheel,audio,video -m daison 
    passwd daison

    echo -ne "\nEdit grub config to enable os os-prober\n"
    nvim /etc/default/grub
    pacman -Sy grub
    grub-install --target=x86_64-efi --efi-directory=/efi/ --bootloader-id=GRUB
    grub-mkconfig -o /boot/grub/grub.cfg
    
    echo -ne "\nEnter root password : "
    passwd

curl -sS https://starship.rs/install.sh | sh
    echo -ne "\nEdit visudo\n"
    visudo
    ;;

  3)
    systemctl enable dhcpcd.service 
    cd /etc/netctl/
    ls
    cp examples/ethernet-dhcp ./custom-dhcp-profile
    ls
    
    echo -ne "\nEdit network interface name and DHCP client\n"
    nvim custom-dhcp-profile

    echo -ne "\nReboot now and check if connected to internet\n"
    ping archlinux.org
    ;;

  4)
    git clone https://github.com/daisonth/.dotfiles.git
    cd .dotfiles
    sudo rm -r /home/daison/.bashrc /home/daison/.bash_profile
    stow .
    sudo pacman -S $(cat /arch_pkg)
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    curl -sS https://starship.rs/install.sh | sh
    curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh
    ;;

esac
