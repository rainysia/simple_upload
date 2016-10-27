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



# Default to working directory
LOCAL_REPO="."
# Default to git pull with FF merge in quiet mode
GIT_COMMAND="git pull --quiet"

# User messages
GU_ERROR_FETCH_FAIL="Unable to fetch the remote repository."
GU_ERROR_UPDATE_FAIL="Unable to update the local repository."
GU_ERROR_NO_GIT="This directory has not been initialized with Git."
GU_INFO_REPOS_EQUAL="The local repository is current. No update is needed."
GU_SUCCESS_REPORT="Update complete."

pull_all() {
    if [ -f $tmp_file ]; then
        rm -f $tmp_file
    fi
    for i in "$"
}






#if [ $# -eq 1 ]; then
	#LOCAL_REPO="$1"
	#cd "$LOCAL_REPO"
#fi

#if [ -d ".git" ]; then
	## update remote tracking branch
	#git remote update >&-
	#if (( $? )); then
		#echo $GU_ERROR_FETCH_FAIL >&2
		#exit 1
	#else
		#LOCAL_SHA=$(git rev-parse --verify HEAD)
		#REMOTE_SHA=$(git rev-parse --verify FETCH_HEAD)
		#if [ $LOCAL_SHA = $REMOTE_SHA ]; then
			#echo $GU_INFO_REPOS_EQUAL
			#exit 0
		#else
			#$GIT_COMMAND
			#if (( $? )); then
				#echo $GU_ERROR_UPDATE_FAIL >&2
				#exit 1
			#else
				#echo $GU_SUCCESS_REPORT
			#fi
		#fi
	#fi
#else
	#echo $GU_ERROR_NO_GIT >&2
	#exit 1
#fi
#exit 0
