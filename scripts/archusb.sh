#!/bin/bash

echo -ne "\nEnter the step No : "
read p

case $p in
  1)
    clear
    cp /media/blah/scripts/archusb.sh /
    echo -ne "\n\n\nPARTITIONING \n" 
    lsblk
    echo -ne "\nSelect a drive to partition [only last alphabet]: "
    read x 
    sgdisk -o -n 1:0:+10M -t 1:EF02 -n 2:0:+500M -t 2:EF00 -n 3:0:0 -t 3:8300 /dev/sd$x 
    echo -ne "\n\n\nFORMATING WITHOUT JOURNAL \n"
    lsblk
    echo -ne "\nEnter the Partition to be formated :  [sdX2] "
    read y
    mkfs.fat -F32 /dev/sd$y 
    echo -ne "\nEnter the root Partition to be formated :  [sdX3] "
    read z
    mkfs.ext4 /dev/sd$z 
    echo -ne "\n\n\nMOUNTING\n"
    lsblk
    mkdir -p /mnt/usb
    mount /dev/sd$z /mnt/usb
    lsblk
    mkdir /mnt/usb/boot
    mount /dev/sd$y /mnt/usb/boot
    echo -ne "\n\n\nINSTALLING BASE SYSTEM\n"
    pacstrap /mnt/usb linux linux-firmware base neovim
    cp /archusb.sh /mnt/usb/
    genfstab -U /mnt/usb > /mnt/usb/etc/fstab
    cat /mnt/usb/etc/fstab
    echo -ne "\n\n\nCHROOT INTO NEW SYSTEM\n"
    arch-chroot /mnt/usb
    ;;

  2)
    clear
    echo -ne "\n\n\nCONFIGURATION\n"
    echo arch > /etc/hostname
    grep -v "#en_US.UTF-8 UTF-8" /etc/locale.gen > file2
    mv file2 /etc/locale.gen 
    sed -i '/#en_US i en_US.UTF-8 UTF-8' /etc/locale.gen 
    hwclock --systohc
    ln -sf /usr/share/zoneinfo/Asia/Kolkat /etc/localtime
    hwclock --systohc
    locale-gen
    echo LANG=en_US.UTF-8 > /etc/locale.conf
    nvim /etc/hosts
    echo -ne "\n\n\nSETUP FSTAB \n"
    nvim /etc/fstab
    echo -ne "\n\n\nSETUP journal config \n"
    mkdir -p /etc/systemd/journald.conf.d
    vim /etc/systemd/journald.conf.d/10-volatile.conf
    echo -ne "\n\n\nSET ROOT PASSWORD :\n "
    passwd
    echo -ne "\n\n\nINSTALLING GRUB\n"
    pacman -S grub efibootmgr
    lsblk
    echo -ne "\n Select the drive to install grub : "
    read x
    grub-install --target=i386-pc --boot-directory /boot --removable /dev/sd$x
    grub-install --target=x86_64-efi --efi-directory /boot --boot-directory /boot --removable
    read b
    grub-mkconfig -o /boot/grub/grub.cfg
    echo -ne "\n\n\nSETUP networking\n"
    ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules
    nvim /etc/systemd/network/20-ethernet.network
    systemctl enable systemd-networkd.service
    systemctl enable systemd-resolved.service
    pacman -S iwd sudo polkit networkmanager
    systemctl enable iwd.service
    cp /etc/systemd/network/20-ethernet.network /etc/systemd/network/20-wlan.network
    nvim /etc/systemd/network/20-wlan.network
    systemctl enable systemd-timesyncd.service
    echo -ne "\n\n\nADD USER\n"
    useradd -m -s /bin/bash -U -G wheel,users,audio,video,input daisn
    passwd daisn
    EDITOR=nvim visudo /etc/sudoers.d/10-sudo
    echo -ne "\n\n\n\nINSTALLATION COMPLETE, REBOOT NOW \n"
    ;;

  3)
    clear
    systemctl start NetworkManager
    systemctl enable NetworkManager
    lsblk
    echo -ne "\nSelect the partition to mount : "
    read x;
    mount /dev/$x /media
    lsblk
    echo -ne "\n\n\nINSTALLING PACKAGES\n"
    cat /media/blah/pacman | xargs sudo pacman -S
    clear
    echo -ne "\n\n\nCLONING dotfiles\n"
    cd
    mkdir ~/git
    cd ~/git
    git clone https://gitlab.com/daisn/dotfiles.git
    git clone https://gitlab.com/daisn/dwm.git
    git clone https://gitlab.com/daisn/dmenu.git
    git clone https://gitlab.com/daisn/st.git
    git clone https://gitlab.com/daisn/slstatus.git
    git clone https://gitlab.com/daisn/scripts.git
    mv ~/git/dotfiles/.moc ~/git/dotfiles/wallpaper ~/git/dotfiles/.bashrc ~/git/dotfiles/.xinitrc ~/git/dotfiles/.Xresources ~/
    mkdir ~/.config
    cp -R ~/git/dotfiles/.config/* ~/.config/
    echo -ne "\n\n\nINSTALLING DWM...\n"
    cd /home/daisn/git/dwm
    sudo make install
    echo -ne "\n\n\nINSTALLING DMENU...\n"
    cd /home/daisn/git/dmenu
    sudo make install
    echo -ne "\n\n\nINSTALLING ST...\n"
    cd /home/daisn/git/st
    sudo make install
    echo -ne "\n\n\nINSTALLING SLSTATUS...\n"
    cd /home/daisn/git/slstatus
    sudo make install
    echo -ne "\n\n\nINSTALLING FONTS...\n"
    sudo mkdir /usr/share/fonts
    sudo mv ~/git/dotfiles/Agave.zip ~/git/dotfiles/JetBrainsMono.zip /usr/share/fonts/
    cd /usr/share/fonts/
    sudo unzip Agave.zip
    sudo unzip JetBrainsMono.zip
    fc-cache -f -v
    sudo rm Agave.zip JetBrainsMono.zip
    sh -c "$(curl -fsSL https://starship.rs/install.sh)"
    echo -ne "\n\n\n\nINSTALATION SUCCESSFUL :)\n"
    sudo rm /archusb.sh
    ;;

  *)
    echo -ne "\nINVALID INPUT!!\n"
    ;;
esac
