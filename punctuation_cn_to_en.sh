#!/bin/bash
#author rainysia <rainysia@gmail.com>
#date 2016-05-30 16:29:15

set -e

if [ -z "$1" ]; then
    echo 'in 1'
    current_path=`pwd`'/'
else
    echo 'in 2'
    current_path=$1
fi

declare -A punctuation_zh_arr punctuation_en_arr file_type_arr

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

#for i in "${!punctuation_zh_arr[@]}"
#do
    #echo "key: $i"
    #echo "value: ${punctuation_zh_arr[$i]}"
    #echo "value: ${punctuation_en_arr[$i]}"
#done
replace_punctuation() {
    if [ ! -f $des_file ]; then
        exit 1
    else
        echo $des_file
        #statements
    fi
}

get_files() {
    echo $current_path
    declare -A des_files
    for i in "${!file_type_arr[@]}"
    do
        echo $current_path, ${file_type_arr[$i]}, $i
        file_type=${file_type_arr[$i]}
        echo "find "$current_path '\( -name ".git" -prune \) -o \( -type f -name "*."'${file_type_arr[$i]} "-print \)"
        des_files[$i]=`find $current_path \( -name ".git" -prune \) -o \( -type f -name "*."${file_type_arr[$i]} -print \)`
    done
    echo $des_files[1]
    echo $des_files[2]
}

get_files
echo $des_files
