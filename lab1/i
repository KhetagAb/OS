#!/bin/bash

if (( $(echo "$1 > $2"|bc) && $(echo "$1 > $2"|bc) ))
then
        echo $1
else
        if (( $(echo "$2 > $3"|bc) ))
        then
                echo $2
        else
                echo $3
        fi
fi
