#!/bin/bash

test_dir="$HOME/test"
success="catalog test was created successfully"
pingFail="CANNOT PING"
url="www.net_nikogo.ru"

mkdir $test_dir && { echo $success > $HOME/report ; touch $test_dir/$(date +"%F_%R"); } ; ping -c 1 $url || echo "$(date +"%F_%R") $pingFail" >> $HOME/report