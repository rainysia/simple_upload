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

declare -a log_proj1 log_work log_proj2
proj_name="proj1 proj2 proj3"
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
log_proj3[2]='console-'${d1_date}_*${file_tailer}
log_proj3[3]='console-'${d2_date}_*${file_tailer}
log_proj3[4]='console-'${d3_date}_*${file_tailer}
log_proj3[5]='console-'${d4_date}_*${file_tailer}

sync_3_day_log() {
    for i in ${proj_name}
    do
        if [ ! -d "$bak_dir$i" ];
        then
            mkdir "$bak_dir$i"
        fi
        logs="log_"${i}"[@]"
        for log in ${!logs}
        do
            scp -P2222 user@123.456.789.10:/logs/project/${i}/$log $bak_dir > /dev/null 2>&1
            full_log=$bak_dir$i/$log
            if [ ${full_log##*.} = "gz" ] > /dev/null 2>&1;
            then
                gzip -d $full_log
            fi
        done
    done
    echo 'Sync done'
}

sync_all_log() {
    for i in ${proj_name}
    do
        if [ ! -d "$bak_dir$i" ];
        then
            mkdir "$bak_dir$i"
        fi
        scp -r -P1022 user@123.456.789.10:/logs/project/${i}/ $bak_dir > /dev/null 2>&1
        echo "All "$i" log sync done!\n";
        for log in `ls -la $bak_dir$i | awk '{print $9}'`
        do
            full_log=$bak_dir$i/$log
            if [ ${full_log##*.} = "gz" ] > /dev/null 2>&1;
            then
                gzip -d $full_log
            fi
        done

    done

    # delete +3days logs
    find $bak_dir$i -mtime +3 -name "*.*"  -exec rm -rf {} \;
    echo 'Sync done'

}

#sync_3_day_log
sync_all_log
