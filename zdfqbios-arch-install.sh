#!/bin/bash
#自动分区 bios 引导安装 archLinux基础系统
dhcpcd

#替换仓库列表
tmpfile=$(mktemp --suffix=-mirrorlist)	
url="https://www.archlinux.org/mirrorlist/?country=CN&protocol=http&protocol=https&ip_version=4"
curl -so ${tmpfile} ${url} 
sed -i 's?^#Server?Server?g' ${tmpfile}
mv -f ${tmpfile} /etc/pacman.d/mirrorlist;
pacman -Sy --noconfirm

pacman -S --nocofirm git wget
# git clone https://github.com/215766520/arch
# sh zdfqbios-arch-install.sh           #自动分区 bios 引导安装 archLinux基础系统
# sh zdfqefi-arch-install.sh            #自动分区 efi  引导安装 archlinux基础系统
# sh sdfqbios-arch-install.sh           #手动分区 bios 引导安装 archLinux基础系统
# sh sdfqefi-arch-install.sh            #手动分区 efi  引导安装 archlinux基础系统
# sh xfce4-install.sh                   #安装 xfce4 桌面环境
# sh app-install-config.sh              #安装相关办公、浏览器以及腾讯软件等
# sh theme-light-locker-settings.sh     #安装主题和图标，并修改锁屏界面

#parted 开始分区 或者 使用 cfdisk 命令 进行手动分区  
#parted 命令 1000MB=1GB，[ -s, 从不提示用户 ]
parted -s  /dev/sda mklabel msdos                          #建立分区表：msdoc or gpt
parted -s  /dev/sda mkpart primary 1M 1G                   #/boot | /boot/efi
parted -s  /dev/sda mkpart primary linux-swap 1G 8G        #swap
parted -s  /dev/sda mkpart primary ext4 8GM 100%           #/ 
#parted -s /dev/sda mkpart primary ext4 8G 30G             #/
#parted -s /dev/sda mkpart primary ext4 30G 100%           #/home
parted -s  /dev/sda set 1 boot on                          #将编号为1的分区的boot标记设定为on(生效) 
parted -s  /dev/sda print                                  #查看分区是否正确

#开始格式化
mkfs.ext2 -F    /dev/sda1   #/boot=ext2 | /boot/efi=vfat  (bios)
#mkfs.vfat -F   /dev/sda1   #/boot=ext2 | /boot/efi=vfat  (efi)
mkswap -f       /dev/sda2
swapon          /dev/sda2
mkfs.ext4 -F    /dev/sda3   #/
#mkfs.ext4 -F   /dev/sda4   #/home

#---------------------

#挂载分区 (bios)
mount       /dev/sda3      /mnt
mkdir -p    /mnt/boot
mount       /dev/sda1      /mnt/boot
mkdir -p    /mnt/home
#mount      /dev/sda4      /mnt/home/

#挂载分区 (efi)
#mount      /dev/sda3      /mnt
#mkdir -p   /mnt/boot
#mkdir -p   /mnt/boot/efi
#mount      /dev/sda1      /mnt/boot/efi
#mkdir -p   /mnt/home
#mount      /dev/sda4      /mnt/home/

lsblk

#---------------------

#最小安装
pacstrap /mnt base linux linux-firmware
#pacstrap /mnt base-devel
pacstrap /mnt nano git wget

#待深究
#pacstrap /mnt base base-devel linux-lts linux-lts-headers linux-firmware wqy-zenhei ttf-dejavu wqy-microhei adobe-source-code-pro-fonts

#生成标卷文件表
genfstab -U /mnt >> /mnt/etc/fstab

#复制 相关文件 到新安装系统根目录
mkdir -p   /mnt/home/arch
cp -rf ./* /mnt/home/arch
cp /etc/pacman.conf /mnt/etc/pacman.conf.bck
cp /etc/pacman.d/mirrorlist.bak /mnt/etc/pacman.d/mirrorlist.bak
cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist

#切换到新系统
arch_chroot() {
	arch-chroot /mnt /bin/bash -c "${1}"
}

#配置系统时间,地区和语言
arch_chroot "ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime"
arch_chroot "hwclock --systohc --utc"
arch_chroot "mkinitcpio -p linux"
sed -i 's?#en_US.UTF-8?en_US.UTF-8?g' /mnt/etc/locale.gen
sed -i 's?#zh_CN.UTF-8?zh_CN.UTF-8?g' /mnt/etc/locale.gen
arch_chroot "locale-gen"
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf   #系统语言（英文）

#安装网络管理程序
arch_chroot "pacman -S --noconfirm iw wpa_supplicant dialog wireless_tools netctl networkmanager networkmanager-openconnect rp-pppoe network-manager-applet net-tools"
arch_chroot "systemctl enable NetworkManager.service"
arch_chroot "pacman -S --noconfirm dhcpcd iputils"
arch_chroot "systemctl enable dhcpcd.service"

#安装配置引导程序（efi引导的话，将grub改成grub-efi-x86_64 efibootmgr）
arch_chroot "pacman -S --noconfirm grub os-prober"     #os-prober 双系统必备
arch_chroot "grub-install --target=i386-pc /dev/sda"   #bios引导
#arch_chroot "grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub"  #efi引导
arch_chroot "grub-mkconfig -o /boot/grub/grub.cfg" 
arch_chroot "passwd root"

#设置主机名/本地域名
#touch /mnt/etc/hostname  #新建文件
read -p "Hostname [ex: archlinux]: " host_name
echo "$host_name" > /mnt/etc/hostname
echo -e "127.0.0.1   localhost.localdomain     localhost" > /mnt/etc/hosts
echo -e "::1         localhost.localdomain     localhost" >> /mnt/etc/hosts
echo -e "127.0.1.1   "$host_name".localdomain  "$host_name"" >> /mnt/etc/hosts

umount -R /mnt
clear

reboot


