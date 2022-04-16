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

    echo -ne "\nSelect a drive to partition (eg: sdc) : "
    read x
    cfdisk /dev/$x
    clear

    lsblk
    lsblk -f
    echo -ne "\nEnter the Partition to be formated as root(eg: sdc1) : "
    read y
    mkfs.ext4 /dev/$y

    mount /dev/$y /mnt
    mkdir /mnt/efi
    mount /dev/sda2 /mnt/efi

    pacstrap /mnt base linux linux-firmware

    genfstab -U /mnt >> /mnt/etc/fstab

    arch-chroot /mnt
    cp /media/arch_install.sh /mnt/

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

    echo -ne "\nEdit visudo\n"
    visudo

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

  4)
    git clone https://github.org/daisonth/.dotfiles.git
    cd .dotfiles
    sudo rm -r /home/daison/.bashrc /home/daison/.bash_profiles
    stow .
    sudo pacman -S $(cat arch_pkg)
