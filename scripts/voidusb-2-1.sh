#!/bin/bash

echo -ne "\nEnter the step No : "
read p

case $p in
  1)
    clear
    cp /media/blah/scripts/voidusb-2-1.sh /
    echo -ne "\n\n\nPARTITIONING \n" 
    lsblk
    echo -ne "\nSelect a drive to partition : "
    read x
    cfdisk /dev/$x -z
    echo -ne "\n\n\nFORMATING WITHOUT JOURNAL \n"
    lsblk
    echo -ne "\nEnter the Partition to be formated : "
    read y
    mkfs.ext4 -O "^has_journal" /dev/$y
    echo -ne "\n\n\nMOUNTING\n"
    lsblk
    mount /dev/$y /mnt
    lsblk
    echo -ne "\n\n\nINSTALLING BASE SYSTEM\n"
    REPO=https://mirrors.cnnic.cn/voidlinux/current
    ARCH=x86_64
    XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO" base-system neovim grub
    echo -ne "\n\n\nMOUNTING sys dev proc\n"
    mount --rbind /sys /mnt/sys && mount --make-rslave /mnt/sys
    mount --rbind /dev /mnt/dev && mount --make-rslave /mnt/dev
    mount --rbind /proc /mnt/proc && mount --make-rslave /mnt/proc
    cp /etc/resolv.conf /mnt/etc
    cp /voidusb-2-1.sh /mnt/
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
    echo -ne "\nEnter the root partition : "
    read y
    read x <<< $(blkid | grep $y | egrep -o '"[^"]+"' | egrep '^.{38}$')
    read z <<< ${x:1:36}
    echo "UUID=$z / ext4 rw,noatime 0 0" > /etc/fstab
    cat /etc/fstab
    echo -ne "\n\n\nSET ROOT PASSWORD :\n "
    passwd
    echo -ne "\n\n\nINSTALLING GRUB\n"
    lsblk
    echo -ne "\n Select the drive to install grub : "
    read x
    grub-install --target=i386-pc --boot-directory /boot --removable /dev/$x
    read b
    xbps-reconfigure -fa
    echo -ne "\n\n\n\nINSTALLATION COMPLETE, REBOOT NOW \n"
    ;;

  3)
    clear
    echo -ne "\n\n\nSTARTING sshd and dhcpcd services\n"
    ln -s /etc/sv/sshd /var/service
    ln -s /etc/sv/dhcpcd /var/service
    lsblk
    echo -ne "\nSelect the partition to mount : "
    read x;
    mount /dev/$x /media
    lsblk
    echo -ne "\n\n\nADD USER\n"
    useradd -m -s /bin/bash -U -G wheel,users,audio,video,input daisn
    passwd daisn
    echo -ne "\n\n\nINSTALLING PACKAGES\n"
    cat /media/blah/scripts/pkg | xargs xbps-install -Sy
    echo -ne "\n\n\n\nChange user to daisn and edit visudo \n"
    exit
    ;;

  4)
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
    sudo rm /voidusb-2-1.sh
    ;;

  *)
    echo -ne "\nINVALID INPUT!!\n"
    ;;
esac
