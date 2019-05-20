#!/bin/bash
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

declare -a log_proj1 log_proj2 log_proj2 sign sign_console
proj_name="proj1 proj2 proj3 sign sign_console"
bak_dir="/home/www/logs/"

file_tailer='.log.gz'
d0_date=`date +%F`.log.`date +%Y%m%d`
d1_date=`date +%F`.log.`date +%Y%m%d`
d2_date=`date -d -1day +%F`.log.`date -d -1day +%Y%m%d`
d3_date=`date -d -2day +%F`.log.`date -d -2day +%Y%m%d`
d4_date=`date -d -3day +%F`.log.`date -d -3day +%Y%m%d`

# proj1
log_proj1[1]='main-'${d0_date}.*
log_proj1[2]='main-'${d1_date}_*${file_tailer}
log_proj1[3]='main-'${d2_date}_*${file_tailer}
log_proj1[4]='main-'${d3_date}_*${file_tailer}
log_proj1[5]='main-'${d4_date}_*${file_tailer}

# proj2
log_proj2[1]='console-'${d0_date}.*
log_proj2[2]='console-'${d1_date}_*${file_tailer}
log_proj2[3]='console-'${d2_date}_*${file_tailer}
log_proj2[4]='console-'${d3_date}_*${file_tailer}
log_proj2[5]='console-'${d4_date}_*${file_tailer}

# proj3
log_proj3[1]='console-'${d0_date}.*
log_proj3[3]='console-'${d2_date}_*${file_tailer}
log_proj3[4]='console-'${d3_date}_*${file_tailer}
log_proj3[5]='console-'${d4_date}_*${file_tailer}

# proj4
log_sign[1]='main'${d0_date}.*
log_sign[3]='main'${d2_date}_*${file_tailer}
log_sign[4]='main'${d3_date}_*${file_tailer}
log_sign[5]='main'${d4_date}_*${file_tailer}

# proj5 existed in proj4 log folder with different name
log_sign_console[1]='console.'${d0_date}.*
log_sign_console[3]='console.'${d2_date}_*${file_tailer}
log_sign_console[4]='console.'${d3_date}_*${file_tailer}
log_sign_console[5]='console.'${d4_date}_*${file_tailer}

sync_3_day_log() {
    for i in ${proj_name}
    do
        #echo $i
        if [ ! -d "$bak_dir$i" ];
        then
            if [ $i=='sign_console' ]; then
                echo $i > /dev/null 2>&1
            else
                mkdir "$bak_dir$i"
            fi
        fi
        logs="log_"${i}"[@]"
        #echo $logs
        for log in ${!logs}
        do
            if [ ${i} == 'sign_console' ]; then
                i='sign'
            fi
            scp -P22 test@192.168.100.200:/var/logs/project/${i}/$log $bak_dir$i > /dev/null 2>&1
            full_log=$bak_dir$i/$log
            if [ ${full_log##*.} = "gz" ] > /dev/null 2>&1; then
                gzip -d -f $full_log
            fi
        done
    done
    echo 'Sync done'
}

sync_all_log() {
    for i in ${proj_name}
    do
        if [ $i == 'sign_console' ]; then
            i='sign'
        fi
        echo $i
        if [ ! -d "$bak_dir$i" ];
        then
            echo "$bak_dir$i"
            mkdir "$bak_dir$i"
        fi
        scp -r -P22 test@192.168.100.200:/var/logs/project/${i}/ $bak_dir > /dev/null 2>&1
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
