#!/bin/bash
# *
# * The script can update all git folder to latest if you want.
# *
# * @author     Rainy Sia <rainysia@gmail.com>
# * @createTime 2016-10-14 13:35:43
# * @lastChange 2016-10-14 13:36:02
#*

set -e
tmp_file='/tmp/_gitfolderarr.txt'

if [ -z "$1" ]; then
    current_path=`pwd`'/'
else
    pre_path=$1
    if [ "${pre_path:0:1}" = "/" ]; then
        current_path=$1
    else
        current_path=`pwd`/$1
    fi
fi
echo $current_path

declare git_folders git_folder_branch

git_folders[1]='order'
git_folders[2]='admin'
git_folders[3]='mq'

pull_all() {
    if [ -f $tmp_file ]; then
        rm -f $tmp_file
    fi
    for i in "$"
}



