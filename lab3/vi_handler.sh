#!/bin/bash
echo $$ > .pid
result=1
operate="+"
sum()
{
  operate="+"
}
mul()
{
  operate="*"
}
stop()
{
  echo "exit by signal, result:"$result
  exit 0
}
trap 'sum' USR1
trap 'mul' USR2
trap 'stop' SIGTERM
while true;
do
  result=$(echo "$result $operate 2"|bc -l)
  echo "result: "$result
  sleep 1
done