#!/bin/bash
#*
# * Sync the folder's git project to latest

# * BASH version num

# * @filename   sync_git_projects.sh
# * @category   CategoryName
# * @package    PackageName
# * @author     Rainy Sia <rainysia@gmail.com>
# * @copyright  2013-2020 BTROOT.ORG
# * @license    https://opensource.org/licenses/MIT license
# * @version    GIT: 0.0.1
# * @createTime 2019-10-14 09:51:53
# * @lastChange 2019-12-16 14:48:01

# * @link http://www.btroot.org

# /bin/bash /sh/sync_git_projects.sh /home/www/git_folders/ origin
set -e
default_branch='master'

# set project parent folder
if [ -z "$1" ]; then
    project_path=`pwd`'/'
else
    pre_path=$1
    if [ "${pre_path:0-1}" = "/" ]; then
        project_path=$1
    else
        project_path=$1"/"
    fi
fi
# set remote alias name, default 'origin', maybe 'upstream'
if [ -z "$2" ]; then
    remote_name='origin'
else
    remote_name=$2
fi

if [ ! -d "$project_path" ]; then
    echo -e "\033[1;31m Wrong Git Parent Project Folder: \033[0m\033[1;36m $project_path \033[0m"
    exit 1
fi

under_projects=`find $project_path -type d -name ".git"`
i_up=0

sync_remote() {
    for i in ${under_projects}
    do
        let i_up+=1
        tmp_project=${i%/*}
        `cd $tmp_project && git stash > /dev/null 2>&1`
        `cd $tmp_project && git remote update -p > /dev/null 2>&1`
        `cd $tmp_project && git checkout $default_branch > /dev/null 2>&1`
        `cd $tmp_project && git pull $remote_name > /dev/null 2>&1`
        echo -e "\033[1;30m Update Current project: \033[0m\033[1;34m $tmp_project $default_branch \033[0m"
    done
}

sync_remote
echo -e "\033[1;36m=====`date '+%F %H:%M:%S'` End to update project branch:\033[0m Update:\033[42;32;1m$i_up\033[0m \033[1;34m $project_path $remote_name $default_branch\033[0m\033[1;36m=====\033[0m"
