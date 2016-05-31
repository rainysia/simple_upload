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

declare -A punctuation_zh_arr punctuation_en_arr

file_type_arr=('txt' 'md')
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


#scandir() {
    #local cur_dir parent_dir work_dir
    #work_dir=$current_path
    #echo $work_dir
    #cd ${work_dir}
    #if [ ${work_dir} = "/" ]
    #then
        #cur_dir=""
    #else
        #cur_dir=$(pwd)
    #fi

    #for dirlist in $(ls ${cur_dir})
    #do
        #if test -d ${dirlist} and ${};then
            #cd ${dirlist}
            #scandir ${cur_dir}/${dirlist}
            #cd ..
        #elif test -f ${cur_dir}/${dirlist}
        #then
            #echo ${cur_dir}/${dirlist}
        #else 
            #exit 1
        #fi
    #done
#}

#if test -d $current_path
#then
    #scandir $current_path
#elif test -f $current_path
#then
    #echo "you input a file but not a directory,pls reinput and try again"
    #exit 1
##elif $current_path 
#else
    #echo "the Directory isn't exist which you input,pls input a new one!!"
    #exit 1
#fi
get_files() {
    echo $current_path
    for ftype in ${file_type_arr[@]}
    do
        find $current_path \( -name ".git" -prune \) -o \( -type f -name "*."$ftype -print \) 
    done
}

get_files 
