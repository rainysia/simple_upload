#!/bin/bash
#*
# * hosts_template to pending/update default hosts.template file into hosts
# * @filename   hosts_templates.sh
# * @author     Riny.Sia <rainysia@gmail.com>
# * @copyright  2006-2017 btroot.org
# * @license    https://opensource.org/licenses/MIT license
# * @version    GIT: 0.0.1
# * @createTime 2017-09-25 16:58:49
# * @lastChange 2017-09-28 17:30:14

# * @link http://btroot.org

# * @notice 1. Need hosts.template file 
# *         2. Need set "default_line" where hosts file need to pend
# *         3. Need set "default_keywords" at first line in hosts.template, such as "127.0.0.1 tom_host_bak_mark_start"
#*
set -e
hosts_base="/etc/"
# test
#hosts_base="/home/tom/Desktop/"

hosts_final="hosts"
hosts_bak="hosts.bak"
hosts_template="hosts.template"

default_line=15
default_keywords="tom_hosts_bak_mark_start"

append_host()
{
    template=${hosts_base}${hosts_template}
    hosts_final=${hosts_base}${hosts_final}
    if [ -f ${template} ]; then
        sudo cp -f "$hosts_final" "$hosts_base$hosts_bak"
        line_final="`wc -l ${hosts_final} | awk '{ print $1 }'`"
        if [ ${line_final} -lt ${default_line} ]; then
            disverse=$(( ${default_line} - ${line_final} ))
            for (( i = ${line_final}; i < "${default_line}" ; i++ )); do
                echo -e "\n" >> ${hosts_final}
            done
        fi

        if grep -q "${default_keywords}" "${hosts_final}"; then
            sudo sed -i "/${default_keywords}/{p;:a;N;\$!ba;d}" "${hosts_final}"
            sudo sed -i "$d" "${hosts_final}"
            line_new_first="`wc -l ${hosts_final} | awk '{ print $1 }'`"
        else
            line_new_first=${default_line}
        fi

        sudo sed -i "${line_new_first}"',$d' ${hosts_final}
        echo "`cat ${template}`" >> "${hosts_final}"
        echo -e "Update hosts template to ${hosts_final}\e[1;32m success! \e[0m\n"
    else
        echo -e "Didn't find hosts.template under \e[1;33m ${hosts_base} \e[0mcan't update\n"
    fi
}

append_host
