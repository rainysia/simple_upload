#!/bin/bash
#*
# * Short description for file

# * BASH version num

# * @filename   xmind_re_lease.sh
# * @category   CategoryName
# * @package    PackageName
# * @author     Rainy Sia <rainysia@gmail.com>
# * @copyright  2013-2016 BTROOT.ORG
# * @license    https://opensource.org/licenses/MIT license
# * @version    GIT: 0.0.1
# * @createTime 2019-08-19 09:51:53
# * @lastChange 2019-10-08 13:53:46

# * @link http://www.btroot.org

#/home/user/.config/XMind ZEN/
#    vana/net/start_timestamps.json
#        firstStartTimestamp unixtimestamp+rand(0,999)
#        startTimestamp1 unixtimestamp+rand(0,999)
#        startTimestamp2
#        startTimestamp3
#    vana/udc/states.json
#        firstVisit:unixtimestamp+rand(0,999)
#        lastVisit:unixtimestamp+rand(0,999)
#    vana/vud/deviceStatus.json
#        start_use_time: unixtimestamp+rand(0,999)
#*

user_who="tom"
dateN=`date '+%N'`
let dateN=10#$dateN
cur_timestamp=$((`date '+%s'`*1000+$dateN/1000000))
full_path="/home/$user_who/.config/XMind ZEN/vana/"
#full_path="/tmp/vana/"

replace_files=("net/start_timestamps.json"
"udc/states.json"
"vud/deviceStatus.json")
keywords=("firstStartTimestamp"
"startTimestamp1"
"startTimestamp2"
"startTimestamp3"
"firstVisit"
"lastVisit"
"start_use_time")

echo -e "\033[1;36m=====`date '+%F %H:%M:%S'` Start to update XMind \033[0m\033[1;34m $full_path  to $cur_timestamp \033[0m\033[1;36m=====\033[0m"

if [[ ! -d "$full_path" ]]; then
    echo -e "\033[1;31m Wrong Xmind vana Folder: \033[0m\033[1;36m $full_path \033[0m"
fi

i_update=0
for xmind_file in ${replace_files[@]}
do
    if [ ! -f "$full_path$xmind_file" ]; then
        echo -e "\033[1;31m Non-exist File: \033[0m\033[1;36m $full_path$xmind_file \033[0m"
    else
        for i in ${keywords[@]}
        do
            if grep -q "${i}" "$full_path$xmind_file"; then
                #echo "Check "$full_path$xmind_file" "and Find "${i}"
                # replace with value
                sed -i "s/\(\"${i}\": \)\([0-9]*\)/\1$cur_timestamp/g" "$full_path$xmind_file"
                let i_update+=1
                echo -e "\033[1;31m Update: \033[0m\033[1;32m  "$full_path$xmind_file" \033[0m\033[1;33m  ${i}\033[0m "
            fi
        done
    fi
done

echo -e "\033[1;36m=====`date '+%F %H:%M:%S'` End to update XMind:\033[0m Update:\033[41;33;1m$i_update\033[0m\033[1;34m $full_path \033[0m\033[1;36m=====\033[0m"
