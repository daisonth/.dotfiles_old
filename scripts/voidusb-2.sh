#!/bin/bash

echo -ne "\nEnter the step No : "
read p

case $p in
  1)
    clear
    cp /media/21-oct/scripts/voidusb-2.sh /
    echo -ne "\nSTEP.1 - PARTITIONING \n" 
    lsblk
    echo -ne "\nSelect a drive to partition : "
    read x
    cfdisk /dev/$x -z
    ;;

  2)
    clear
    echo -ne "\nSTEP.2 - FORMATING WITHOUT JOURNAL \n"
    lsblk
    echo -ne "\nEnter the Partition to be formated : "
    read x
    mkfs.ext4 -O "^has_journal" /dev/$x
    ;;

  3)
    clear
    echo -ne "\nSTEP.3 - MOUNTING\n"
    lsblk
    echo -ne "\nEnter the partition to be mounted\n"
    read x
    mount /dev/$x /mnt
    lsblk
    ;;

  4)
    clear
    echo -ne "\nSTEP.4 - INSTALLING BASE SYSTEM\n"
    REPO=https://mirrors.cnnic.cn/voidlinux/current
    ARCH=x86_64
    XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO" base-system neovim grub
    ;;

  5)
    clear
    echo -ne "\nSTEP.5 - MOUNTING sys dev proc\n"
    mount --rbind /sys /mnt/sys && mount --make-rslave /mnt/sys
    mount --rbind /dev /mnt/dev && mount --make-rslave /mnt/dev
    mount --rbind /proc /mnt/proc && mount --make-rslave /mnt/proc
    cp /etc/resolv.conf /mnt/etc
    cp /voidusb-2.sh /mnt/
    ;;

  6)
    clear
    echo -ne "\nSTEP.6 - CHROOT INTO NEW SYSTEM\n"
    PS1='(chroot) # ' chroot /mnt/ /bin/bash
    ;;

  7)
    clear
    echo -ne "\nSTEP.7 - CONFIGURATION\n"
    echo void > /etc/hostname
    grep -v "#en_US.UTF-8 UTF-8" /etc/default/libc-locales > file2
    mv file2 /etc/default/libc-locales  
    sed -i '/#en_US i en_US.UTF-8 UTF-8' /etc/default/libc-locales 
    ln -sf /usr/share/zoneinfo/Asia/Kolkat /etc/localtime
    hwclock --systohc
    echo -ne "\nGENERATING LOCALE FILES \n"
    xbps-reconfigure -f glibc-locales
    ;;

  8)
    clear
    echo -ne "\nSTEP.8 - SETUP FSTAB \n"
    lsblk
    echo -ne "\nEnter the root partition : "
    read y
    read x <<< $(blkid | grep $y | egrep -o '"[^"]+"' | egrep '^.{38}$')
    read z <<< ${x:1:36}
    echo "UUID=$z / ext4 rw,noatime 0 0" > /etc/fstab
    cat /etc/fstab
    ;;

  9)
    clear
    echo -ne "\nSTEP.9 - SET ROOT PASSWORD :\n "
    passwd
    ;;

  10)
    clear
    echo -ne "\nSTEP.10 - INSTALLING GRUB\n"
    lsblk
    echo -ne "\n Select the drive to install grub : "
    read x
    grub-install --target=i386-pc --boot-directory /boot --removable /dev/$x
    read b
    xbps-reconfigure -fa
    echo -ne "\nINSTALLATION COMPLETE, REBOOT NOW \n"
    ;;

  11)
    clear
    echo -ne "\nSTEP.11 - STARTING sshd and dhcpcd services\n"
    ln -s /etc/sv/sshd /var/service
    ln -s /etc/sv/dhcpcd /var/service
    lsblk
    echo -ne "\nSelect the partition to mount : "
    read x;
    mount /dev/$x /media
    ;;

  12)
    clear
    echo -ne "\nSTEP.12 - ADD USER\n"
    useradd -m -s /bin/bash -U -G wheel,users,audio,video,input daisn
    passwd daisn
    ;;

  13)
    clear
    echo -ne "\nSTEP.13 - INSTALLING PACKAGES\n"
    cat /media/21-oct/scripts/pkg | xargs xbps-install -Sy
    ;;

  14)
    clear
    echo -ne "\nSTEP.14 - Change user to daisn and edit visudo \n"
    exit
    ;;

  15)
    clear
    echo -ne "\nSTEP.15 - GIT CLONE\n"
    cd
    git clone https://gitlab.com/daisn/dotFiles.git
    mv ~/dotFiles/.config ~/dotFiles/.moc ~/dotFiles/wallpaper ~/dotFiles/.bashrc ~/dotFiles/.xinitrc ~/dotFiles/.Xresources ~/
    mkdir audio videos books screenshot other documents acadamics 
    echo -ne "\nCOMPILING SOFTWARE...\n"
    cd /home/daisn/dotFiles/dwm
    sudo make install
    cd /home/daisn/dotFiles/dmenu
    sudo make install
    cd /home/daisn/dotFiles/st
    sudo make install
    cd /home/daisn/dotFiles/slstatus
    sudo make install
    sudo rm /voidusb-2
    ;;

  *)
    echo -ne "\nINVALID INPUT!!\n"
    ;;
esac
