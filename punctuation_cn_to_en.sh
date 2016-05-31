#!/bin/bash
#author rainysia <rainysia@gmail.com>
#date 2016-05-30 16:29:15

set -e
tmp_file='/tmp/_tmp_filearr.txt'

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
#echo $current_path

declare punctuation_zh_arr punctuation_en_arr file_type_arr

file_type_arr[1]='txt'
file_type_arr[2]='md'

# https://zh.wikipedia.org/wiki/%E6%A0%87%E7%82%B9%E7%AC%A6%E5%8F%B7
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
punctuation_zh_arr[27]='—'
punctuation_zh_arr[28]='﹏'

punctuation_en_arr[1]="."
punctuation_en_arr[2]="?"
punctuation_en_arr[3]='!'
punctuation_en_arr[4]=","
punctuation_en_arr[5]=","
punctuation_en_arr[6]=";"
punctuation_en_arr[7]=":"
punctuation_en_arr[8]='"'
punctuation_en_arr[9]='"'
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
punctuation_en_arr[27]='-'
punctuation_en_arr[28]='_'


replace_punctuation() {
    if [ ! -f $line ]; then
        exit 1
    else
        if [ "$(uname)" == "Darwin" ]; then
            for i in "${!punctuation_zh_arr[@]}"
            do
                sed -i '' "s/${punctuation_zh_arr[$i]}/${punctuation_en_arr[$i]}/g" $line
            done
        elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
            for i in "${!punctuation_zh_arr[@]}"
            do
                sed -i "s/${punctuation_zh_arr[$i]}/${punctuation_en_arr[$i]}/g" $line
            done
        elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
            exit 1
        else
            exit 1
        fi
        echo "Punctuation translate done in $line"
    fi
}

get_files() {
    if [ -f $tmp_file ]; then
        rm -f $tmp_file
    fi
    for i in "${!file_type_arr[@]}"
    do
        file_type=${file_type_arr[$i]}
        find $current_path \( -name ".git" -prune \) -o \( -type f -name "*."${file_type_arr[$i]} -print \) >> $tmp_file
    done

    cat $tmp_file | while read line
    do
        replace_punctuation
    done
}

get_files
