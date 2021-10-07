#!/bin/bash

cat /var/log/anaconda/syslog | grep -e "[0-9:-:]\{8\},[[:digit:]]\+ INFO" > info.log