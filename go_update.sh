#!/bin/bash
#*
# * This script will help to upgrade go version and go package version including bin

# * BASH version num

# * @filename   go_update.sh
# * @category   CategoryName
# * @package    PackageName
# * @author     Rainy Sia <rainysia@gmail.com>
# * @copyright  2013-2021 BTROOT.ORG
# * @license    https://opensource.org/licenses/MIT license
# * @version    GIT: 0.0.2
# * @createTime 2020-03-05 15:29:36
# * @lastChange 2021-04-13 00:26:54

# * @link http://www.btroot.org
#*
# 1, update go
#       tar -C /usr/local -xzf go1.12.4.linux-amd64.tar.gz
# 2, update package
#       /bin/bash /home/sh/sync_git_projects.sh /usr/local/gotom/ origin
# 3, compile package and install
#      cd xxx  go build && go install
# 4, Update to go1.16.6
# /bin/bash /home/sh/go_update.sh
set -e
declare -a third_packages
golang_package='/home/softs/develop/golang/go1.16.6.linux-amd64.tar.gz'
golang_path='/usr/local/'
third_packages_path='/usr/local/gotom/src/'
third_packages_repo_path=(
   'github.com/klauspost/asmfmt/cmd/asmfmt'
   'github.com/go-delve/delve/cmd/dlv'
   'github.com/kisielk/errcheck'
   'github.com/davidrjenni/reftools/cmd/fillstruct'
   'github.com/rogpeppe/godef'
   'github.com/mdempsky/gocode'
   'github.com/stamblerre/gocode'
   'github.com/zmb3/gogetdoc'
   'golang.org/x/tools/cmd/goimports'
   'golang.org/x/lint/golint'
   'github.com/alecthomas/gometalinter'
   'github.com/fatih/gomodifytags'
   'golang.org/x/tools/gopls'

   'golang.org/x/tools/cmd/gorename'
   'github.com/jstemmer/gotags'
   'golang.org/x/tools/cmd/guru'
   'github.com/koron/iferr'
   'github.com/josharian/impl'
   'honnef.co/go/tools/cmd/keyify'
   'github.com/fatih/motion'
)
go_install() {
    `tar -C $golang_path -xzf $golang_package`
}
go_build_install() {
    # some of it may need to run `go mod init` at first
	# gometalinter: go mod init, go mod vendor, go build && go install
    `go build && go install`
}

# 1, detect the go root
if [ ! -d "$golang_path" ]; then
    echo -e "\033[1;31m Wrong Go Root Folder: \033[0m\033[1;36m $golang_path \033[0m"
    exit 1
fi
# 2, verify new version > current go version
detect_go() {
    action="install"
    if command -v go > /dev/null; then
        current_version=`go version`
        action="update"
    else
        echo -e "\033[1;30m will install   : \033[0m\033[1;31mgo\033[0m \033[1;30mcommand because it's not installed.\033[0m"
        current_version=''
    fi
    # 3, install or update go ( you may want to stop install again. so comment the below go_install )
    go_install
    new_version=`go version`
    echo -e "\033[1;30m $action Golang:\033[0m\033[1;36m $current_version\033[0m \033[1;37mto\033[0m\033[1;32m $new_version \033[0m"
}
# You can comment the below function to skip detect and install go
detect_go
# 4, update third-party packages, suggest run the command manually ( you may need to run the below # script manually )
# You can comment the below script command to skip sync the go src repositories project and run manually.
# sync_git_projects.sh is here:https://github.com/rainysia/sync_git_projects
`/bin/bash /home/sh/sync_git_projects.sh $third_packages_path origin`
# 5, switch
git_clean_f="git clean -f"
git_rm_vendor="rm -rf vendor"
git_checkout="git checkout ./"
go_mod_init="go mod init"
go_mod_vendor="go mod vendor"
go_install="go install"

for i in ${third_packages_repo_path[@]}
do
    temp_project=$third_packages_path$i

    if [ ! -d "$temp_project" ]; then
        echo -e "\033[1;31m Wrong Go Third Package Folder: \033[0m\033[1;36m $temp_project \033[0m"
    else
        # github.com/klauspost/asmfmt/cmd/asmfmt'
        # klauspost/asmfmt needs `go mod init` then `cd ./cmd/asmfmt` and then `go build && go install`
        # mdempsky/gocode needs `go mod init` and `go mod vendor`
        # jstemmer/gotags needs `go mod init`
        # koron/iferr needs `go mod init`
        # zmb3/gogetdoc need `go mod vendor`
        # kisielk/errcheck need `go install` directly
        # alecthomas/gometalinter need `go mod init, go mod vendor, go build && go install`
        echo -e "\033[1;30m start install: \033[0m\033[1;34m $temp_project \033[0m"
        if [[ "$i" =~ "klauspost/asmfmt" ]]; then
            `cd $temp_project && cd ../../ && ${git_clean_f} &> /dev/null`
            #`cd $temp_project && cd ../../ && ${go_mod_init} &> /dev/null`
            `cd $temp_project && go_build_install &> /dev/null`
        elif [[ "$i" =~ "jstemmer/gotags" || "$i" =~ "koron/iferr" ]]; then
            `cd $temp_project && ${git_clean_f} &> /dev/null`
            `cd $temp_project && ${go_mod_init} &> /dev/null`
            `cd $temp_project && go_build_install &> /dev/null`
        elif [[ "$i" =~ "zmb3/gogetdoc" ]]; then
            `cd $temp_project && ${git_checkout} &> /dev/null`
            `cd $temp_project && ${go_mod_vendor} &> /dev/null`
            `cd $temp_project && go_build_install &> /dev/null`
        elif [[ "$i" =~ "kisielk/errcheck" ]]; then
            `cd $temp_project && ${go_install} &> /dev/null`
        elif [[ "$i" =~ "alecthomas/gometalinter" || "$i" =~ "mdempsky/gocode" ]];then
            `cd $temp_project && ${git_clean_f} &> /dev/null`
            `cd $temp_project && ${git_rm_vendor} &> /dev/null`
            `cd $temp_project && ${git_checkout} &> /dev/null`
            `cd $temp_project && ${go_mod_init} &> /dev/null`
            `cd $temp_project && ${go_mod_vendor} &> /dev/null`
            `cd $temp_project && go_build_install `
        else
            `cd $temp_project && go_build_install &> /dev/null`
        fi
        echo -e "\033[1;30m end go build && install: \033[0m\033[1;34m $temp_project \033[0m"
    fi
done
# 6, new
echo -e "\033[1;36m=====`date '+%F %H:%M:%S'` End update:\033[0m Go Version:\033[42;32;1m$current_version\033[0m to\033[1;34m $new_version \033[0m\033[1;36m=====\033[0m"
