#!/bin/bash

#ArchLinux美化之界面美化
sudo pacman -S --noconfirm plank  #底部Docky: plank
systemctl enable plank
#systemctl disable plank

sudo pacman -S --noconfirm   arc-gtk-theme  arc-icon-theme                      #arc主题/图标
sudo pacman -S --noconfirm   arc-solid-gtk-theme                                #arc-solid主题——Arc-Dark-solidv     //绿紫，带白
#sudo pacman -S --noconfirm  adapta-gtk-theme                                   #adapta主题——Adapta-Npltp-Eta       //绿黑，带白
#sudo pacman -S --noconfirm  vimix-gtk-theme                                    #vimix主题——vimix-dark-laptop-doder //绿蓝

sudo pacman -S --noconfirm   numix-circle-icon-theme-git  numix-icon-theme-git  #主题图标：numix——扁平化绚丽黑色调
sudo pacman -S --noconfirm   elementary-icon-theme                              #类似Windows图标
#安装完成后，打开plank；第二，在“设置”——“外观”中启用主题和图标即可

#---

#修改 xfce4 锁屏界面为 light-locker-settings
#卸载默认锁屏 xfce4-screensaver
sudo pacman -R --noconfirm xfce4-screensaver

#安装 light-locker
sudo pacman -S --noconfirm light-locker

#安装图形化设置工具
yay -S --noconfirm light-locker-settings

#命令行设置xfce4 默认使用
#/usr/bin/xflock4  #xfce4 默认使用 xflock4 来进行锁屏
xfconf-query -c xfce4-session -p /general/LockCommand -s "light-locker-command --lock"
