#!/bin/bash

backup_path=/home/user
report=/home/user/backup-report
restore=/home/user/restore
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

last_date=$(ls $backup_path | grep -E "^Backup-[0-9]{4}(-[0-9]{2}){2}" | sort -n | tail -n 1 | cut -d "-" -f 2-)

if [ -z $last_date ]; then
    echo "[$timestamp] Cannot find any Backups. Upback stopped" >> $report
    exit 0
fi

if [ ! -d $restore ]; then
    mkdir $restore
fi

target_path=$backup_path/Backup-$last_date;
backup_list=$(ls $target_path | grep -vE ".*\.backup\.[0-9]{4}(-[0-9]{2}){2}" )

echo "[$timestamp] Upback completed." >> $report
for i in $backup_list; do
    cp -R $target_path/$i $restore
    echo "[$timestamp] File $target_path/$i restored." >> $report
done
