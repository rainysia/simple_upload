#!/bin/bash
# * @author     Rainy Sia <rainysia@gmail.com>
# * @createTime 2016-10-14 13:35:43
# * @lastChange 2016-10-27 18:59:23
#*

set +e
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

declare git_proj_folders git_folder_branch git_remote_project

git_proj_folders[1]='vimrc'
git_proj_folders[2]='vimrcbak'
git_proj_folders[3]='dotfiles'
git_proj_folders[4]='tmux'
git_proj_folders[5]='tmux2'

git_folder_branch[1]='master'
git_folder_branch[2]='master'
git_folder_branch[3]='master'
git_folder_branch[4]='master'
git_folder_branch[5]='master'

git_remote_project[1]='origin'
git_remote_project[2]='origin'
git_remote_project[3]='origin'
git_remote_project[4]='origin'
git_remote_project[5]='origin'

# Default to git pull with FF merge in quiet mode
git_command_pull="git pull --quiet"
git_command_update="git remote update"
git_command_merge="git merge "
git_command_stash_save="git stash save"
git_command_stash_pop="git stash pop"
git_command_checkout="git checkout"
git_command_br="git branch | awk '{ print NR=$2 }'"
git_local_sha="git rev-parse --verify HEAD"
git_remote_sha="git rev-parse --verify FETCH_HEAD"

# User messages
GU_ERR_PROJ="The_git_project_don't_exist."
GU_ERR_NO_GIT="This_directory_has_not_been_initialized_with_Git."
GU_ERR_FETCH_FAIL="Unable_to_fetch_the_remote_repository."
GU_ERR_UPDATE_FAIL="Unable_to_update_the_local_repository."
GU_ERR_UNKNOWN="Unknown_error"
GU_ERR_NO_RIGHT="Sorry,_but_we_got_Permission_denied."
GU_INFO_CURRENT="The_local_repository_is_current._No_update_is_needed."
GU_INFO_SUCCESS="Update_complete."

pull_all() {
    if [[ -f $tmp_file ]]; then
        rm -f $tmp_file
    fi

    for i in "${!git_proj_folders[@]}"
    do
        #printf "%s\t%s\n" "$i" "${git_proj_folders[$i]}"
        proj_name="${git_proj_folders[$i]}"
        proj_folder="$current_path""${proj_name}"
        proj_info_no=0
        proj_info=''
        proj_style=''

        if [ ! -d "$proj_folder" ]; then
            proj_info_no=1
        else
            cd "$proj_folder"
            if [[ ! -d ".git" ]]; then
                proj_info_no=2
            else
                cur_branch=`git branch | awk '{ print NR=$2 }'`
                cur_err=`$git_command_stash_save  2>&1 /dev/null`
                if [ $? ]; then
                    if [ $(expr substr "$cur_err" 1 2) == "No" ]; then
                        proj_info_no=3
                    elif [ $(expr substr "$cur_err" 1 2) == "fa" ]; then
                        proj_info_no=4
                    else
                        proj_info_no=5
                    fi
                else
                    proj_info_no=6
                fi
            fi
            cd $current_path
        fi

        if [[ "$proj_info_no" -eq 1 ]]; then
            proj_info=${GU_ERR_PROJ}
            proj_style="\033[1;31m[%s]\e[0m: %s\n"
        elif [[ "$proj_info_no" -eq 2 ]]; then
            proj_info=${GU_ERR_NO_GIT}
            proj_style="\033[1;31m[%s]\e[0m: %s\n"
        elif [[ "$proj_info_no" -eq 3 ]]; then
            proj_info=${GU_INFO_CURRENT}
            proj_style="\033[1;32m[%s]\e[0m: %s\n"
        elif [[ "$proj_info_no" -eq 4 ]]; then
            proj_info=${GU_ERR_NO_RIGHT}
            proj_style="\033[1;31m[%s]\e[0m: %s\n"
        elif [[ "$proj_info_no" -eq 5 ]]; then
            proj_info=${GU_ERR_UNKNOWN}
            proj_style="\033[1;31m[%s]\e[0m: %s\n"
        else
            proj_info=${GU_INFO_SUCCESS}
            proj_style="\033[1;32m[%s]\e[0m: %s\n"
        fi

        printf "${proj_style}" ${proj_name} ${proj_info}
    done
}
echon() {
    echo -e "\n"
}

git_run() {
    LOCAL_SHA=$(git rev-parse --verify HEAD)
    REMOTE_SHA=$(git rev-parse --verify FETCH_HEAD)
    if [ $LOCAL_SHA = $REMOTE_SHA ]; then
        echo $GU_INFO_REPOS_EQUAL
        exit 0
    else
        $GIT_COMMAND
        if (( $? )); then
            echo $GU_ERROR_UPDATE_FAIL >&2
            exit 1
        else
            echo $GU_SUCCESS_REPORT
        fi
    fi
}

echon
pull_all
echon

