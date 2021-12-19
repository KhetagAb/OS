#!/bin/bash

file=$1
trash=$HOME/.trash
log=$HOME/.trash.log

if [ $# -ne 1 ]; then
    echo "Usage: untrash <file-name>"
    exit 1
fi

for i in $(grep "|"$file"|" $log); do
    path=$(echo $i | awk -F '|' '{print $1}')
    trash_id=$(echo $i | awk -F '|' '{print $3}')

    if [ -e $trash/$trash_id ]; then
        echo "Do you want to recovery $path/$file? (y/n)"
        read answer

        if [ $answer == "y" ]; then
            target_path=$HOME
            if [ -d $path ]; then
                target_path=$path
            fi

            file_name=$file

            while [ -e $target_path/$file_name ]; do
                echo "File $target_path/$file_name already exists. Enter new name:"
                read file_name
            done

            ln $trash/$trash_id $target_path/$file_name

            echo "Saved file $path/$file was moved from trash as $target_path/$file_name"

        else
            echo "Saved file $path/$file annihilated from trash"
        fi

        rm $trash/$trash_id
    else
        echo "Warning: Saved file $path/$file was lost from trash"
    fi
done

grep -v "|"$file"|" $log > $log"0"
mv $log"0" $log

