#!/bin/bash
#*
# * Short description for file

# * BASH version num

# * @filename   bak_debian.sh
# * @category   CategoryName
# * @package    PackageName
# * @author     Rainy Sia <rainysia@gmail.com>
# * @copyright  2013-2016 BTROOT.ORG
# * @license    https://opensource.org/licenses/MIT license
# * @version    GIT: 0.0.1
# * @createTime 2019-07-12 09:40:05
# * @lastChange 2019-07-12 09:40:05

# * @link http://www.btroot.org
#*
host_dir=`cd /home/sh`
path_user="tom"
now_date=`date +%Y%m%d`
bak_dir="/home/"${path_user}"/Desktop/bak_${now_date}/"

bak_file="${bak_dir}${now_date}"
bak_root="$bak_dir/root/"
bak_user="$bak_dir/user/"
bak_etc="$bak_dir/etc/"
bak_other="$bak_dir/other/"
black_hole=" > /dev/null 2>&1"

dir_detech()
{
    if [ ! -d "$bak_dir" ];
    then
        mkdir "$bak_dir"
    fi
    if [ ! -d "$bak_root" ]; then
        mkdir "$bak_root"
    fi
    if [ ! -d "$bak_user" ]; then
        mkdir "$bak_user"
    fi
    if [ ! -d "$bak_etc" ]; then
        mkdir "$bak_etc"
    fi
    if [ ! -d "$bak_other" ]; then
        mkdir "$bak_other"
    fi
}

bak_file(){
    dir_detech
    echo -e "\033[1;36m=====`date '+%F %H:%M:%S'` Start to backup system:\033[0m\033[1;34m $bak_dir \033[0m\033[1;36m=====\033[0m"

    #==========1, root bak start==========
    echo -e "\033[1;30m Back               : \033[0m\033[1;32m root_file \033[0m"

    root_file=('.bashrc'
    '.zshrc'
    '.tommy_ssh'
    '.company_ssh'
    '.gitconfig'
    '.profile'
    '.terminfo/mostlike.txt')

    for i in ${root_file[*]};
    do
        if [ -f "/root/$i" ]; then
            cp /root/$i $bak_root
            echo -e "\033[1;30m Backup file success: \033[0m\033[1;33m "/root/$i" \033[0m"
        else
            echo -e "\033[1;31m File is not existed: \033[0m\033[1;36m "/root/"$i \033[0m"
        fi
    done
    #==========1, root bak end============

    #==========2, user bak start==========
    user_file=('.vimrc'
    '.bashrc'
    '.zshrc'
    '.tommy_ssh'
    '.company_ssh'
    '.gitconfig'
    '.profile'
    '.local/share/notes/Notes/Notes'
    )
    echo -e "\033[1;30m Back               : \033[0m\033[1;32m user_file \033[0m"
    for i in ${user_file[*]};
    do
        if [ -f "/home/$path_user/$i" ]; then
            cp /home/$path_user/$i $bak_user
            echo -e "\033[1;30m Backup file success: \033[0m\033[1;33m "/home/$path_user/$i" \033[0m"
        else
            echo -e "\033[1;31m File is not existed: \033[0m\033[1;36m "/home/$path_user/$i" \033[0m"
        fi
    done
    #==========2, user bak end============

    #==========3, etc bak start===========
    etc_file=('hosts'
    'resolv.conf'
    'tmux.conf'
    'timezone'
    'sudoers'
    'memcached.conf'
    'php-codesniffer/CodeSniffer.conf'
    )
    echo -e "\033[1;30m Back               : \033[0m\033[1;32m etc_file \033[0m"
    for i in ${etc_file[*]};
    do
        if [ -f "/etc/$i" ]; then
            cp /etc/$i $bak_etc
            echo -e "\033[1;30m Backup file success: \033[0m\033[1;33m "/etc/$i" \033[0m"
        else
            echo -e "\033[1;31m File is not existed: \033[0m\033[1;36m "/etc/$i" \033[0m"
        fi
    done

    etc_conf=`find /etc/ -name "*conf*"`
    tar -zcvf $bak_etc"conf.tar.gz" $etc_conf  > /dev/null 2>&1
    echo -e "\033[1;30m Backup conf success: \033[0m\033[1;33m "$bak_etc"conf.tar.gz \033[0m"
    etc_cnf=`find /etc/ -name "*.cnf*"`
    tar -zcvf $bak_etc"cnf.tar.gz" $etc_cnf  > /dev/null 2>&1
    echo -e "\033[1;30m Backup cnf  success: \033[0m\033[1;33m "$bak_etc"cnf.tar.gz \033[0m"
    #==========3, etc bak end=============

    #==========4, soft bak start==========
    soft_bak=('apache2'
    'apt'
    'docker'
    'gdm3'
    'gnome'
    'init'
    'init.d'
    'lightdm'
    'logrotate.d'
    'lsyncd'
    'modprobe.d'
    'mysql'
    'network'
    'NetworkManager'
    'nginx'
    'php'
    'redis'
    'shadowsocks'
    'shadowsocksr'
    'ssh'
    'supervisor'
    'v2ray'
    'vim'
    'X11'
    'xfce4'
    )
    echo -e "\033[1;30m Back               : \033[0m\033[1;32m soft \033[0m"
    for i in ${soft_bak[*]};
    do
        if [ -d "/etc/$i" ]; then
            tar -zcvf $bak_etc$i".tar.gz" /etc/$i  > /dev/null 2>&1
            echo -e "\033[1;30m Backup soft success: \033[0m\033[1;33m "/etc/$i" \033[0m"
        else
            echo -e "\033[1;31m Soft is not existed: \033[0m\033[1;36m "/etc/$i" \033[0m"
        fi
    done
    #==========4, soft bak end============

    #==========5, others bak start========
    echo -e "\033[1;30m Back               : \033[0m\033[1;32m others \033[0m"
    dpkg --get-selections > $bak_other"packagelist.txt"  > /dev/null 2>&1
    other_bak=("/home/sh"
    'home/'$path_user'/.icons'
    '/usr/share/icons/'
    '/usr/share/applications/'
    '/home/vc/git/'
    '/usr/share/fonts/'
    '/home/work/doc/'
    '/home/work/project/'
    '/home/work/self/'
    '/home/work/sql/'
    '/home/work/soft/'
    )
    for i in ${other_bak[*]};
    do
        if [ -d "$i" ]; then
            tar -zcvf $bak_other$i".tar.gz" $i  > /dev/null 2>&1
            echo -e "\033[1;30m Back other  success: \033[0m\033[1;33m "$i" \033[0m"
        else
            echo -e "\033[1;30m Back is not existed: \033[0m\033[1;33m "$i" \033[0m"
        fi
    done
    #==========5, others bak end==========

    #chmod 777 -R $bak_dir
    echo -e "\033[1;36m=====`date '+%F %H:%M:%S'` Backup System finished:\033[0m\033[1;34m $bak_dir \033[0m\033[1;36m=====\033[0m"
}

bak_file
