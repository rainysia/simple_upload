#!/bin/bash
#*
# * Short description for file

# * BASH version num

# * @filename   sync_remote_server_log.sh
# * @category   CategoryName
# * @package    PackageName
# * @author     Rainy Sia <rainysia@gmail.com>
# * @copyright  2013-2019 BTROOT.ORG
# * @license    https://opensource.org/licenses/MIT license
# * @version    GIT: 0.0.1
# * @createTime 2013-06-11 16:15:24
# * @lastChange 2019-06-11 16:15:24

# * @link http://www.btroot.org
#*

set -e
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

declare -A log_project
proj_name="proj1 proj2 proj3 proj4"
bak_dir="/home/www/logs/"

file_tailer='.log.gz'
d0_date=`date +%F`.log.`date +%Y%m%d`
d1_date=`date +%F`.log.`date +%Y%m%d`
d2_date=`date -d -1day +%F`.log.`date -d -1day +%Y%m%d`
d3_date=`date -d -2day +%F`.log.`date -d -2day +%Y%m%d`
d4_date=`date -d -3day +%F`.log.`date -d -3day +%Y%m%d`

# log_format
log_format[1]='main'
log_format[2]='main-'
log_format[3]='console.'
log_format[4]='console-'

log_tailer[1]=${d0_date}.*
log_tailer[2]=${d2_date}_*${file_tailer}
log_tailer[3]=${d3_date}_*${file_tailer}
log_tailer[4]=${d4_date}_*${file_tailer}

# proj1, log_format[2] + log_tailer
# proj2, log_format[4] + log_tailer
# proj3, log_format[4] + log_tailer
# proj4, log_format[1] + log_tailer
# proj5, log_format[3] + log_tailer
# proj6, log_format[4] + log_tailer
# proj7, log_format[4] + log_tailer
# proj8, log_format[2] + log_tailer
log_project=(
    [proj1]="2"
    [proj2]="4"
    [proj3]="4"
    [proj4]="1"
    [proj5]="3"
    [proj6]="4"
    [proj7]="4"
    [proj8]="2"
)
sync_3_day_log() {
    for i in ${proj_name}
    do
        #echo $bak_dir$i
        if [ ! -d "$bak_dir$i" ];
        then
            if [ "$i" == "proj4" ]; then
                echo $i > /dev/null 2>&1
            else
                mkdir -p "$bak_dir$i"
            fi
        fi

        #echo $i
        proj_log_arr[1]=${log_format[${log_project[$i]}]}${log_tailer[1]}
        proj_log_arr[2]=${log_format[${log_project[$i]}]}${log_tailer[2]}
        proj_log_arr[3]=${log_format[${log_project[$i]}]}${log_tailer[3]}
        proj_log_arr[4]=${log_format[${log_project[$i]}]}${log_tailer[4]}

        for log in ${proj_log_arr[@]};
        do
            # rewrite target folder
            if [ $i == 'proj4' ]; then
                i='proj3'
            fi

            #echo "scp -P22 test@123.123.123.123:/var/chroot/logs/project/${i}/$log $bak_dir$i"
            scp -P22 test@123.123.123.123:/var/chroot/logs/project/${i}/$log $bak_dir$i > /dev/null 2>&1
            full_log=$bak_dir$i/$log

            if [ ${full_log##*.} = "gz" ] > /dev/null 2>&1; then
                gzip -d -f $full_log
            fi
        done
    done
    echo 'Sync 3 days log done'
}

sync_all_log() {
    for i in ${proj_name}
    do
        if [ "$i" == "proj4" ]; then
            i='proj3'
        fi
        echo $i
        if [ ! -d "$bak_dir$i" ];
        then
            echo "$bak_dir$i"
            mkdir -p "$bak_dir$i"
        fi
        #echo "scp -r -P22 test@123.123.123.123:/var/chroot/logs/project/${i}/ $bak_dir"
        scp -r -P22 test@123.123.123.123:/var/chroot/logs/project/${i}/ $bak_dir > /dev/null 2>&1
        echo "All "$i" log sync done!\n";
        for log in `ls -la $bak_dir$i | awk '{print $9}'`
        do
            full_log=$bak_dir$i/$log
            if [ ${full_log##*.} = "gz" ] > /dev/null 2>&1;
            then
                echo $full_log
                gzip -f -d $full_log
            fi
        done
    done

    # delete +3days logs
    #find $bak_dir$i -mtime +3 -name "*.*"  -exec rm -rf {} \;
    echo 'Sync done'

}

sync_3_day_log
#sync_all_log
