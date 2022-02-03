#!/bin/bash

echo -ne "\nEnter the step No : "
read step

case $step in
  1)
    clear
    echo -ne "\n\n\nPARTITIONING \n" 
    lsblk
    echo -ne "\nSelect a drive to partition (eg: sdc) : "
    read x
    cfdisk /dev/$x -z
    echo -ne "\n\n\nFORMATING WITHOUT JOURNAL \n"
    lsblk
    echo -ne "\nEnter the Partition to be formated (eg: sdc1) : "
    read y
    mkfs.ext4 -O "^has_journal" /dev/$y
    echo -ne "\n\n\nMOUNTING\n"
    lsblk
    mount /dev/$y /mnt
    lsblk
    echo -ne "\n\n\nINSTALLING BASE SYSTEM\n"
    REPO=https://mirrors.cnnic.cn/voidlinux/current
    ARCH=x86_64
    XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO" base-system neovim grub git
    echo -ne "\n\n\nMOUNTING sys dev proc\n"
    mount --rbind /sys /mnt/sys && mount --make-rslave /mnt/sys
    mount --rbind /dev /mnt/dev && mount --make-rslave /mnt/dev
    mount --rbind /proc /mnt/proc && mount --make-rslave /mnt/proc
    cp /etc/resolv.conf /mnt/etc
    cp /media/void-build.sh /mnt/
    echo -ne "\n\n\nCHROOT INTO NEW SYSTEM\n"
    PS1='(chroot) # ' chroot /mnt/ /bin/bash
    ;;

  2)
    clear
    echo -ne "\n\n\nCONFIGURATION\n"
    echo void > /etc/hostname
    grep -v "#en_US.UTF-8 UTF-8" /etc/default/libc-locales > file2
    mv file2 /etc/default/libc-locales  
    sed -i '/#en_US i en_US.UTF-8 UTF-8' /etc/default/libc-locales 
    ln -sf /usr/share/zoneinfo/Asia/Kolkat /etc/localtime
    hwclock --systohc
    echo -ne "\nGENERATING LOCALE FILES \n"
    xbps-reconfigure -f glibc-locales
    echo -ne "\n\n\nSETUP FSTAB \n"
    lsblk
    echo -ne "\nEnter the root partition (eg: sdc1) : "
    read y
    read x <<< $(blkid | grep $y | egrep -o '"[^"]+"' | egrep '^.{38}$')
    read z <<< ${x:1:36}
    echo "UUID=$z / ext4 rw,noatime 0 0" > /etc/fstab
    cat /etc/fstab
    echo -ne "\n\n\nSET ROOT PASSWORD :\n "
    passwd
    echo -ne "\n\n\nADD USER\n"
    useradd -m -s /bin/bash -U -G wheel,users,audio,video,input daisn
    passwd daisn
    echo -ne "\n\n\nINSTALLING GRUB\n"
    lsblk
    echo -ne "\n Select the drive to install grub (eg: sdc) : "
    read x
    grub-install --target=i386-pc --boot-directory /boot --removable /dev/$x
    xbps-reconfigure -fa
    echo -ne "\n\n\n\nINSTALLATION COMPLETE, REBOOT NOW and login as DAISN\n"
    ;;

  3)
    clear
    echo -ne "\n\n\nSTARTING sshd and dhcpcd services\n"
    ln -s /etc/sv/sshd /var/service
    ln -s /etc/sv/dhcpcd /var/service
    ping voidlinux.org
    echo -ne "\n\n\nCLONING dotfiles & INSTALLING PACKAGES\n"
    cd
    git clone https://github.com/daisonth/.dotfiles.git
    cat ~/.dotfiles/scripts/pkg | xargs sudo xbps-install -Sy
    mkdir ~/.config
    cd .dotfiles/
    stow . 
    echo -ne "\n\n\nINSTALLING DWM...\n"
    cd /home/daisn/.dotfiles/dwm
    sudo make install
    echo -ne "\n\n\nINSTALLING DMENU...\n"
    cd /home/daisn/.dotfiles/dmenu
    sudo make install
    echo -ne "\n\n\nINSTALLING ST...\n"
    cd /home/daisn/.dotfiles/st
    sudo make install
    echo -ne "\n\n\nINSTALLING SLSTATUS...\n"
    cd /home/daisn/.dotfiles/slstatus
    sudo make install
    echo -ne "\n\n\nINSTALLING FONTS...\n"
    sudo mkdir /usr/share/fonts
    sudo cp ~/.dotfiles/classic_console_neue.zip ~/.dotfiles/Agave.zip ~/.dotfiles/JetBrainsMono.zip /usr/share/fonts/
    cd /usr/share/fonts/
    sudo unzip Agave.zip
    sudo unzip JetBrainsMono.zip
    sudo unzip classic_console_neue.zip
    fc-cache -f -v
    sudo rm -R Agave.zip JetBrainsMono.zip classic_console_neue.zip
    sh -c "$(curl -fsSL https://starship.rs/install.sh)"
    echo -ne "\n\n\n\nINSTALATION SUCCESSFUL :)\n"
    sudo rm /void-build.sh
    ;;

  *)
    echo -ne "\nINVALID INPUT!!\n"
    ;;
esac
