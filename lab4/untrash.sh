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
    trashId=$(echo $i | awk -F '|' '{print $3}')

    if [ -e $trash/$trashId ]; then
        echo "Do you want to recovery $path/$file? (y/n)"
        read answer

        if [ $answer == "y" ]; then
            targetPath=$HOME
            if [ -d $path ]; then
                targetPath=$path
            fi

            fileName=$file

            while [ -e $targetPath/$fileName ]; do
                echo "File $targetPath/$fileName already exists. Enter new name:"
                read fileName
            done

            ln $trash/$trashId $targetPath/$fileName

            echo "Saved file $path/$file was moved from trash as $targetPath/$fileName"

        else
            echo "Saved file $path/$file annihilated from trash"
        fi

        rm $trash/$trashId
    else
        echo "Warning: Saved file $path/$file was lost from trash"
    fi
done

grep -v "|"$file"|" $log > $log"0"
mv $log"0" $log

