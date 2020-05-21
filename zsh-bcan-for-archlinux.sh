#!/bin/bash

#安装zsh(安装完zsh后好像会自动退出脚本，这样子的话，插件就得重启后自己复制输入了，不过问题不大，反正添加插件也得输入一下)
#sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

sudo rm -rf  /root/.oh-my-zsh/  ~/.oh-my-zsh/
sudo rm -f  ~/.zsh_history  ~/.zshrc.pre-oh-my-zsh  ~/.zshrc
sh ./zsh-install-qf.sh

# 安装 incr 自动补全插件
sudo mkdir ~/.oh-my-zsh/plugins/incr/
sudo cp ./incr-0.2.zsh  ~/.oh-my-zsh/plugins/incr/  #将 incr-0.2.zsh 文件复制到 ~/.oh-my-zsh/plugins/incr 文件夹
sh -c 'echo "" >> ~/.zshrc'  #增加一行空格
sh -c 'echo "source ~/.oh-my-zsh/plugins/incr/incr*.zsh" >> ~/.zshrc'

# 安装 zsh-syntax-highlighting：高亮插件
git clone https://gitee.com/lwcsmail/zsh-syntax-highlighting.git  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/
# sudo cp -rf ./zsh-syntax-highlighting/  ~/.oh-my-zsh/custom/plugins/
sh -c 'echo "source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc'
# 然后打开 ~/.zshrc 配置文件，plugins=(git  zsh-syntax-highlighting)
sh -c "sed -i 's?plugins=(git)?plugins=(git  zsh-syntax-highlighting)?g' ~/.zshrc"
# 将 zsh默认主题：ZSH_THEME="robbyrussell"，更改为：ZSH_THEME="agnoster"
sh -c "sed -i 's?ZSH_THEME=\"robbyrussell\"?ZSH_THEME=\"agnoster\"?g' ~/.zshrc"
sudo xed ~/.zshrc

#    nano ~/.zshrc,将主题改成：ZSH_THEME="agnoster" （zsh-syntax-highlighting必须放最下面。这个不会写，只能这样子备注了，重启后照着这个改就好了）
#    下载命令补全以及高亮插件
#    cd ~/.oh-my-zsh/custom/plugins/
#    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
#    git clone https://github.com/zsh-users/zsh-autosuggestions
#    加入插件，即 nano ~/.zshrc 在 plugins=(git) 上加入插件名字，改成
#    plugins=(
#       git
#       zsh-autosuggestions
#       zsh-syntax-highlighting               
#      )              

echo '请重启系统...'
# reboot  #重启
# halt    #关机
# logout  #注销

cd
zsh


