#!/bin/bash

#!/bin/bash
while true; do
  read LINE

  if [[ $LINE == "*" ]]
  then
     echo "MUL" > pipe
  else
     echo $LINE > pipe
  fi

  if [[ $LINE == "QUIT" ]]
  then
    exit
  fi

  if ! [[ $LINE =~ ^[0-9]+ || $LINE == "+" || $LINE == "*" ]]
  then
    echo "ERROR"
    exit 1
  fi
done