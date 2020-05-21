#!/bin/bash

#添加 清华 Archlinuxcn 源 for /etc/pacman.conf
sudo chmod 777 /etc/pacman.d/mirrorlist
sudo sh -c 'echo -e "[archlinuxcn]\nServer = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch" >> /etc/pacman.conf'
#sudo sh -c 'echo -e "[archlinuxcn]\nServer = https://mirrors.ustc.edu.cn/archlinuxcn/\$arch" >> /etc/pacman.conf'
ping -c 5 127.0.0.1
sudo pacman -Syy && sudo pacman -S --noconfirm archlinuxcn-keyring -y

sudo sh -c "sed -i 's?\#\Color?\Color?g' /etc/pacman.conf"
sudo sh -c "sed -i 's?\#\VerbosePkgLists?\VerbosePkgLists?g' /etc/pacman.conf"
sudo sh -c "sed -i 's?\#\[multilib]?\[multilib]?g' /etc/pacman.conf"
sudo sh -c "sed -i '93s?\#\Include = /etc/pacman.d/mirrorlist?\Include = /etc/pacman.d/mirrorlist?g' /etc/pacman.conf"  #sed修改指定93行
sudo sh -c "sed -i '95s?\#\Include = /etc/pacman.d/mirrorlist?\Include = /etc/pacman.d/mirrorlist?g' /etc/pacman.conf"  #sed修改指定95行
#sudo sh -c "sed -i '93c Include = /etc/pacman.d/mirrorlist' /etc/pacman.conf"  #sed直接替换93行 为新的内容
ping -c 5 127.0.0.1
sudo pacman -Syy --noconfirm

#安装AUR助手 yay yaourt
sudo pacman -S --noconfirm yay yaourt fakeroot

#命令行下载器：可使用aria2多线程多链接加速（建议提前安装，可提高更新系统或者安装软件速度）
sudo pacman -S --noconfirm aria2

#安装中文输入法
yay -S --noconfirm fcitx fcitx-im fcitx-configtool fcitx-sogoupinyin
sudo cp ./libfcitx-qt.so.0 /usr/lib/  #已下载 libfcitx-qt.so.0 文件

#配置汉化
#echo "LANG=zh_US.UTF-8" >> /etc/locale.conf   #系统语言（中文）
#sudo mv xprofile-xfce4 ~/.xprofile
#touch ~/.xprofile
echo -e "#配置语言" > ~/.xprofile
echo -e "export LANG=zh_CN.UTF-8" >> ~/.xprofile
echo -e "export LANGUAGE=zh_CN:en_US" >> ~/.xprofile
echo -e "export LC_CTYPE=en_US.UTF-8" >> ~/.xprofile
echo -e "export LC_ALL="zh_CN.UTF-8"" >> ~/.xprofile
echo -e "" >> ~/.xprofile
echo -e "#配置fcitx (ManJaro)" >> ~/.xprofile
echo -e "export XIM=fcitx" >> ~/.xprofile
echo -e "export XIM_PROGRAM=fcitx" >> ~/.xprofile
echo -e "export GTK_IM_MODULE=fcitx" >> ~/.xprofile
echo -e "export QT_IM_MODULE=fcitx" >> ~/.xprofile
echo -e "export XMODIFIERS="@im=fcitx"" >> ~/.xprofile
cat  ~/.xprofile

#删除一些不需要的软件
sudo pacman -Rs --noconfirm audacious            #无损音乐播放
sudo pacman -Rs --noconfirm audacious-plugins    #audacious插件
sudo pacman -Rs --noconfirm guayadeque           #播放器
sudo pacman -Rs --noconfirm vlc                  #播放器
sudo pacman -Rs --noconfirm thunderbird          #阅读邮件或新闻
sudo pacman -Rs --noconfirm libreoffice-still    #libreoffice办公软件
sudo pacman -Rs --noconfirm ms-office-online     #在线办公软件
sudo pacman -Rs --noconfirm firefox              #火狐浏览器
sudo pacman -Rs --noconfirm steam-manjaro        #steam游戏
sudo pacman -Rs --noconfirm xfburn               #xfce4刻录工具
sudo pacman -Rs --noconfirm xfce4-dict           #xfce4自带词典
sudo pacman -Rs --noconfirm xfce4-notes-plugin   #便签
sudo pacman -Rs --noconfirm orage                #orage日历
sudo pacman -Rs --noconfirm hexchat              #通讯工具hexchat
sudo pacman -Rs --noconfirm pidgin               #pidgin通讯程序
sudo pacman -Rs --noconfirm libpurple            #libpurple为Adium服务提供网络层连接库
sudo pacman -Rs --noconfirm mousepad             #简易文本编辑器

#安装基本软件
sudo pacman -S --noconfirm create_ap                        #无线AP 创建wifi热点
sudo pacman -S --noconfirm pamac-aur                        #archlinux 软件管理器
sudo pacman -S --noconfirm neofetch                         #neofetch 或 screenfetch可以在终端里输出你的系统logo和状态。
sudo pacman -S --noconfirm ntfs-3g                          #NTFS分区的读写支持
sudo pacman -S --noconfirm gvfs gvfs-mtp                    #通过MTP协议用gvfs挂载android手机
sudo pacman -S --noconfirm p7zip file-roller unrar ark      #压缩解压工具

yay -S --noconfirm google-chrome                            #google-chrome（谷歌浏览器）,pacman
#yay -S --noconfirm firefox firefox-i18n-zh-cn              #firefox（火狐浏览器）,pacman
yay -S --noconfirm wps-office-cn ttf-wps-fonts wps-office-mui-zh-cn   ##安装wps（全家桶）,pacman
yay -S --noconfirm netease-cloud-music                      #网易云音乐,pacman
yay -S --noconfirm tencentvideo                             #腾讯视频
sudo pacman -S --noconfirm xed notepadqq typora             #文档编辑软件
sudo pacman -S --noconfirm fsearch-git                      #搜索工具

sudo pacman -S --noconfirm gparted                          # gparted 分区编辑器
sudo pacman -S --noconfirm gnome-disk-utility  gdisk        # gnome 磁盘管理工具
sudo pacman -S --noconfirm timeshift                        #系统备份与还原工具
sudo pacman -S --noconfirm gufw                             #Linux中最简单的防火墙之一

sudo pacman -S --noconfirm playonlinux                      #类 wine 工具
sudo pacman -S --noconfirm virtualbox                       #虚拟机
#启动必须:更新所有软件后再装virtualbox，然后重启后再运行此命令
#sudo modprobe vboxdrv vboxnetadp vboxnetflt vboxpci

yay -S --noconfirm synology-assistant               #安装群晖nas局域网管理软件,pacman
sudo pacman -S --noconfirm putty                    #PuTTY 连接工具软件，用户远程登录管理服务器

#deepin 系列软件
#sudo pacman -S --noconfirm deepin-picker           #深度取色器
sudo pacman -S --noconfirm deepin-screenshot        #深度截图
sudo pacman -S --noconfirm deepin-system-monitor    #系统状态监控
#yay -S --noconfirm deepin-wine-wechat              #微信
#yay -S --noconfirm deepin-wine-tim                 #腾讯TIM，打开速度较慢
yay -S --noconfirm deepin.com.wechat2
yay -S --noconfirm deepin.com.qq.office             #deepin版 腾讯TIM,pacman
yay -S --noconfirm deepin.com.thunderspeed          #迅雷极速版

#下载工具
yay -S --noconfirm uget                             #uget下载器,pacman
sudo pacman -S --noconfirm qbittorrent              #torrent下载器
yay -S --noconfirm nutstore                         #坚果云,pacman
sudo pacman -S --noconfirm baidunetdisk-bin         #百度网盘

#图形工具
sudo pacman -S --noconfirm gimp                     #PS
sudo pacman -S --noconfirm inkscape                 #AI
sudo pacman -S --noconfirm krita                    #绘画软件
yay -S --noconfirm trimage                          #图案压缩/跨平台无损图片优化工具
sudo pacman -S --noconfirm converseen               #图片格式转换工具
#yay -S --noconfirm xnconvert                       #图片格式转换工具

sudo pacman -S --noconfirm audacity                 #音频处理软件

sudo pacman -S --noconfirm kdenlive                 #视频剪辑
sudo pacman -S --noconfirm openshot                 #视频剪辑
sudo pacman -S --noconfirm handbrake                #视频转码器

sudo pacman -S --noconfirm simplescreenrecorder     #录屏软件，可选定音频输入
sudo pacman -S --noconfirm obs-studio               #视频直播录制软件


#中文汉化
sudo pacman -S--noconfirm thunderbird-i18n-zh-cn gimp-help-zh_cn man-pages-zh_cn


#系统全面更新
sudo pacman -Syyu

#清理垃圾
sudo pacman -Scc --noconfirm

#---
 
#安装系统图标字体主题包（重启后把shell,gtk.图标等改成这些就好了）
#yay -S --noconfirm gtk-theme-arc-git numix-circle-icon-theme-git
#git clone https://github.com/powerline/fonts.git --depth=1
#mv fonts source-code-pro-medium-italic
#mv source-code-pro-medium-italic /usr/share/fonts/
#cd /usr/share/fonts/source-code-pro-medium-italic
#bash install.sh
#cd

#---

#clear
#reboot

    
