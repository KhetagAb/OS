#!/bin/bash

file=$1
trash=$HOME/.trash
log=$HOME/.trash.log

if [ $# -ne 1 ]; then
    echo "Usage: rmtrash <file>"
    exit 1
fi

if [ ! -e $PWD/$file ]; then
    echo "File $file does not exist"
    exit 1
fi

if [ ! -d $trash ]; then
	mkdir $trash
fi

if [ ! -e $log ]; then
    touch $log
fi

latest=$(($(ls $trash | sort -n | tail -n 1) + 1))
if [ latest == "" ]; then
    latest=1
fi

ln $file "$trash/$latest"
rm $file

echo "$PWD|$file|$latest" >> $log
