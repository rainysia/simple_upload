#!/bin/bash
#*
# * Clean Git merged branch

# * BASH version num

# * @filename   git_branch_clean.sh
# * @category   CategoryName
# * @package    PackageName
# * @author     Rainy Sia <rainysia@gmail.com>
# * @copyright  2013-2016 BTROOT.ORG
# * @license    https://opensource.org/licenses/MIT license
# * @version    GIT: 0.0.1
# * @createTime 2019-03-06 13:16:50
# * @lastChange 2019-03-07 15:49:50
# * @link http://www.btroot.org

# * Steps
# 1, set project path
# 2, set remote name, default upstream
# 3, set target branch, default master/develop
# 4, check history
# 5, delete
# ./git_branch_clean.sh /home/www/project upstream
# ./git_branch_clean.sh /home/www/project upstream true # will use today as keep_keywords

set -e
declare -a need_del_branches_arr protect_branches_arr
default_branch='develop'
protect_branches_arr=(develop master latest)

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
if [ -z "$2" ]; then
    remote_name='upstream'
else
    remote_name=$2
fi

if [ -z "$3" ]; then
    keep_keywords=`date +%Y%m%d`
else
    keep_keywords=$3
fi
if [ ! -d "$project_path"'.git' ]; then
    echo -e "\033[1;31m Wrong Git Project Folder: \033[0m\033[1;36m $project_path \033[0m"
    exit 1
fi

let branch_len=${#remote_name}+1
all_branches=`cd $project_path && git branch -r | grep $remote_name | grep -v "$remote_name/HEAD"`
i_del=0
i_no=0
i_ke=0


`cd $project_path && git remote update -p > /dev/null 2>&1`
`cd $project_path && git stash > /dev/null 2>&1`
`cd $project_path && git checkout $default_branch > /dev/null 2>&1`

echo -e "\033[1;36m=====`date '+%F %H:%M:%S'` Start to handle project branch:\033[0m\033[1;34m $project_path $remote_name $default_branch\033[0m\033[1;36m=====\033[0m"
for i in ${all_branches}; do
    i_len=${#i}
    _branch_name=${i:$branch_len:$i_len}

    if echo ${protect_branches_arr[@]} | grep -w $_branch_name &> /dev/null; then
        echo -e "\033[1;30m Keep protected branch: \033[0m\033[1;33m $_branch_name\033[0m"
    else
        _sha_id=`cd $project_path && git log $remote_name/$_branch_name --pretty=oneline  | head -1 | cut -d ' ' -f1 | cut -b-7`
        if [[ `cd $project_path && git log --oneline | grep $_sha_id` ]]; then
            if [[ $_branch_name =~ $keep_keywords ]]; then
                echo -e "\033[1;30m Keep Keywords  branch: \033[0m\033[1;34m $remote_name/$_branch_name $_sha_id \033[0m"
                let i_ke+=1
            else
                if [[ $_branch_name =~ "HEAD" ]]; then
                    echo -e "\033[1;30m Keep Current branch: \033[0m\033[1;34m $remote_name/$_branch_name $_sha_id \033[0m"
                else
                    `cd $project_path && git push $remote_name --delete $_branch_name > /dev/null 2>&1`
                    echo -e "\033[1;31m Delete merged branch: \033[0m\033[1;32m  $remote_name/$_branch_name $_sha_id \033[0m"
                    let i_del+=1
                fi
            fi
        else
            echo -e "\033[1;30m Keep no merged branch: \033[0m\033[1;34m $remote_name/$_branch_name $_sha_id \033[0m"
            let i_no+=1
        fi
    fi
done
echo -e "\033[1;36m=====`date '+%F %H:%M:%S'` End to handle project branch:\033[0m deleted:\033[41;33;1m$i_del\033[0m keep:\033[42;32;1m$i_ke\033[0m no merged:\033[43;32;1m$i_no\033[0m\033[1;34m $project_path $remote_name $default_branch\033[0m\033[1;36m=====\033[0m"
