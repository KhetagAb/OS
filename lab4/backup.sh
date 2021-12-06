#!/bin/bash

backup_path=/home/user
source_path=/home/user/source
report=/home/user/backup-report

sources=$(ls $source_path)

timestamp=$(date "+%Y-%m-%d %H:%M:%S")
now_date=$(date +%Y-%m-%d)
last_date=$(ls $backup_path | grep -E "^Backup-[0-9]{4}(-[0-9]{2}){2}" | sort -n | tail -n 1 | cut -d "-" -f 2-)

if [ -z $last_date ]; then
    last_unix=0
else
    last_unix=$(date -d $last_date +%s)
fi

now_unix=$(date -d $now_date +%s)
if (( (now_unix - last_unix) / 86400 > 7 )); then
    target_path=$backup_path/"Backup-$now_date"

    mkdir $target_path

    echo "[$timestamp] Directory $target_path was created." >> $report
    for i in $sources; do
        cp $source_path/$i $target_path
        echo "[$timestamp] File: $source_path/$i" >> $report
    done
else
    target_path=$backup_path/"Backup-$last_date"

    echo "[$timestamp] Update $target_path. Date: $now_date." >> $report
    for i in $sources; do
        source_file=$source_path/$i
        backup_file=$target_path/$i
        if [ ! -f $backup_file ]; then
            cp $source_file $target_path
            echo "[$timestamp] New file $source_file copied" >> $report
        else
            actual_size=$(stat $source_file -c%s)
            backup_size=$(stat $backup_file -c%s)
            if [ $actual_size -eq $backup_size ]; then
                echo "[$timestamp] File $source_file is actual" >> $report
            else
                mv $backup_file $backup_file.backup.$now_date
                cp $source_file $target_path
                echo "[$timestamp] File $source_file updated. Old version: $backup_file.backup.$now_date" >> $report
            fi
        fi
    done
fi
