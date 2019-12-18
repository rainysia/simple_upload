#!/bin/bash
#*
# * restart supervisord when it exited
# * Add the below command into crontab
# * */2 * * * * /bin/bash ./supervisord_watching.sh

# * BASH version num

# * @filename   supervisord_watching.sh
# * @category   CategoryName
# * @package    PackageName
# * @author     Rainy Sia <rainysia@gmail.com>
# * @copyright  2013-2020 BTROOT.ORG
# * @license    https://opensource.org/licenses/MIT license
# * @version    GIT: 0.0.3
# * @createTime 2018-06-19 10:41:06
# * @lastChange 2019-12-18 11:11:47

# * @link http://www.btroot.org
#*
set -e
log_path='/var/log/supervisor/'
now=`date '+%F %H:%M:%S'`
spname='dddd'
if [ ! -d "$log_path" ]; then
    mkdir "$log_path"
fi
supervisord_res=`ps aux | grep '/usr/bin/supervisord' | grep -v 'grep' | awk ' { print NR=$2 }' | sed -n 1p`
if [ ! -n "$supervisord_res" ]; then
    `ps aux | grep php | grep -v "php-fpm" | grep -v "grep" | awk ' {print $2} ' | xargs kill -9`
    /bin/bash /etc/init.d/supervisor start
    echo "\n=============start=================\n$now restart supervisor by Tom because it's stop\n=============end===================" >> $log_path"supervisord.log"
else
    supervisord_process=`supervisorctl status | grep $spname | awk ' { print NR=$2 }' | sed -n 1p`
    if [ $supervisord_process != 'RUNNING' ]; then
        supervisord_process_name=`supervisorctl status | grep $spname | sed -n 1p | awk ' { print NR=$1 }'`
        `ps aux | grep $spname | grep -v "grep\|node\|clone\|git" | awk ' {print $2} ' | xargs kill -9`
        /usr/bin/supervisorctl stop $supervisord_process_name  >> /dev/null 2>&1
        /usr/bin/supervisorctl start $supervisord_process_name >> /dev/null 2>&1
        echo "\n=============start=================\n$now restart $supervisord_process_name by Tom because it's Stopped \n=============end===================" >> $log_path"supervisord.log"
    fi
fi
