#!/bin/bash
#author rainysia <rainysia@gmail.com>
#date 2016-05-30 16:29:15

set -e

if [ -z "$1" ]; then
    current_path=`pwd`'/'
else
    current_path=$1
fi

# https://zh.wikipedia.org/wiki/%E6%A0%87%E7%82%B9%E7%AC%A6%E5%8F%B7
punctuation_arr=()
punctuation_zh_arr[1]='。'
punctuation_zh_arr[2]='？'
punctuation_zh_arr[3]='！'
punctuation_zh_arr[4]='，'
punctuation_zh_arr[5]='、'
punctuation_zh_arr[6]='；'
punctuation_zh_arr[7]='：'
punctuation_zh_arr[8]='“'
punctuation_zh_arr[9]='”'
punctuation_zh_arr[10]='‘'
punctuation_zh_arr[11]='’'
punctuation_zh_arr[12]='（'
punctuation_zh_arr[13]='）'
punctuation_zh_arr[14]='［'
punctuation_zh_arr[15]='］'
punctuation_zh_arr[16]='【'
punctuation_zh_arr[17]='】'
punctuation_zh_arr[18]='《'
punctuation_zh_arr[19]='》'
punctuation_zh_arr[20]='〈'
punctuation_zh_arr[21]='〉'
punctuation_zh_arr[22]='─'
punctuation_zh_arr[23]='－'
punctuation_zh_arr[24]='～'
punctuation_zh_arr[25]='＿'
punctuation_zh_arr[26]='…'


punctuation_en_arr[1]='.'
punctuation_en_arr[2]='?'
punctuation_en_arr[3]='!'
punctuation_en_arr[4]=','
punctuation_en_arr[5]='.'
punctuation_en_arr[6]=';'
punctuation_en_arr[7]=':'
punctuation_en_arr[8]='"'
punctuation_en_arr[9]=''
punctuation_en_arr[10]="'"
punctuation_en_arr[11]="'"
punctuation_en_arr[12]='('
punctuation_en_arr[13]=')'
punctuation_en_arr[14]='['
punctuation_en_arr[15]=']'
punctuation_en_arr[16]='['
punctuation_en_arr[17]=']'
punctuation_en_arr[18]='<'
punctuation_en_arr[19]='>'
punctuation_en_arr[20]='<'
punctuation_en_arr[21]='>'
punctuation_en_arr[22]='-'
punctuation_en_arr[23]='-'
punctuation_en_arr[24]='~'
punctuation_en_arr[25]='_'
punctuation_en_arr[26]='...'

punctuation_zh_cn=('。' '？' '！' '，' '、' '；' '：' \
'“' '”' '‘' '’' '（' '）' '［' '］' '【' '】' '《' '》' '〈' '〉' \
'─' '－' '～' '＿' '…')

punctuation_en=('.' '?' '!' ',' '.' ';' ':' \
'"' '"' "'" "'" '(' ')' '[' ']' '[' ']' '<' '>' '<' '>' \
'-' '-' '~' '_' '...')

#echo ${punctuation_zh_cn[@]}
#echo ${punctuation_en[@]}
#for p in "${punctuation_zh_arr[@]}"; do
    #echo $p
#done


scandir() {
    local cur_dir parent_dir work_dir
    work_dir=$current_path
    echo $work_dir
    cd ${work_dir}
    if [ ${work_dir} = "/" ]
    then
        cur_dir=""
    else
        cur_dir=$(pwd)
    fi


    for dirlist in $(ls ${cur_dir})
    do
        if test -d ${dirlist};then
            cd ${dirlist}
            scandir ${cur_dir}/${dirlist}
            cd ..
        else
            echo ${cur_dir}/${dirlist}
        fi
    done
}

if test -d $current_path
then
    scandir $current_path
elif test -f $current_path
then
    echo "you input a file but not a directory,pls reinput and try again"
    exit 1
else
    echo "the Directory isn't exist which you input,pls input a new one!!"
    exit 1
fi
