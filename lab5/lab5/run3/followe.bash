touch log/memory.log
touch log/swap.log
touch log/proc.log

while true; do
  free > free.temp
  top -b -n1 > top.temp

  cat free.temp | head -n2 | tail -n1 >> log/memory.log
  cat free.temp | head -n3 | tail -n1 >> log/swap.log
  cat top.temp | tail -n +8 | head -n33 >> log/proc.log
  sleep 1s
done

rm free.temp
rm top.temp