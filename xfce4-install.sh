#!/bin/bash

#检查网络
systemctl enable dhcpcd
systemctl start  dhcpcd
ping -c 4 www.qq.com

#添加普通用户
read -p "Username [ex: archlinux]: " User
pacman -S --noconfirm sudo zsh
#useradd -m -g users -G wheel -s /bin/bash $User
useradd -m -g users -G wheel -s /bin/zsh $User
passwd $User
sed -i 's?\# \%wheel ALL=(ALL) ALL?\%wheel ALL=(ALL) ALL?g' /etc/sudoers
sed -i 's?\# \%wheel ALL=(ALL) NOPASSWD: ALL?\%wheel ALL=(ALL) NOPASSWD: ALL?g' /etc/sudoers

#pacman -S --noconfirm xfce4 xfce4-goodies sddm   #精简安装xfce4
#systemctl enable sddm
#systemctl disable sddm

#图像界面安装
pacman -S --noconfirm xorg xorg-xinit xorg-xrandr
#pacman -S --noconfirm xorg-server xorg-server-utils xorg-utils
#pacman -S --noconfirm mesa xorg-twm xorg-xclock
#pacman -S --noconfirm light-locker xfce4-power-manager

#安装桌面环境
pacman -S --noconfirm xfce4 xfce4-goodies lightdm lightdm-gtk-greeter xdg-user-dirs
systemctl enable lightdm
#systemctl disable lightdm

#安装驱动程序
pacman -S --noconfirm ttf-dejavu wqy-microhei                             #字体包
#pacman -S --noconfirm xf86-input-synaptics                               #触摸板驱动
pacman -S --noconfirm intel-ucode                                         #下来可以使用intel版本QQ
#pacman -S --noconfirm amd-ucode                                          #AMD处理器微代码修补程序
pacman -S --noconfirm pulseaudio pulseaudio-alsa alsa-utils alsa-oss      #安装声音软件包 //声卡驱动alsa-utils
systemctl enable alsa-state.service
systemctl start  alsa-state.service
#pacman -S --noconfirm xf86-video-intel                                   #intel显卡
#pacman -S --noconfirm xf86-video-ati                                     # AMD 显卡
#pacman -S --noconfirm xf86-video-nv                                      #英伟达显卡
#pacman -S --noconfirm xf86-video-vmware                                  #vmware虚拟显卡
#pacman -S --noconfirm xf86-video-vesa                                    #VirtualBox虚拟显卡

reboot

