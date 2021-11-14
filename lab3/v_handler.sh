#!/bin/bash

result=1
operate='+'

(tail -f pipe) |
while true; do
  read LINE;
  case $LINE in
  QUIT)
    echo "exit, result: "$result
    killall tail
    exit
  ;;
  MUL)
    operate='*'
  ;;
  +)
    operate='+'
  ;;
  [0-9]*)
    result=$(echo "$result $operate $LINE"|bc -l)
    echo "result: "$result
  ;;
  *)
    echo "ERROR"
    exit 1
  ;;
  esac
done