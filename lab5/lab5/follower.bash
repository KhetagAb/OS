touch log/memory.log
touch log/swap.log
touch log/proc.log
touch log/proc1.log
touch log/proc2.log
touch log/proc3.log
touch log/proc4.log
touch log/proc5.log

while true; do
  free > free.temp
  top -b -n1 > top.temp

  cat free.temp | head -n2 | tail -n1 >> log/memory.log
  cat free.temp | head -n3 | tail -n1 >> log/swap.log
  cat top.temp | tail -n +8 | head -n3 >> log/proc.log
  cat top.temp | tail -n +8 | head -n1 >> log/proc1.log
  cat top.temp | tail -n +9 | head -n1 >> log/proc2.log
  cat top.temp | tail -n +10 | head -n1 >> log/proc3.log
  cat top.temp | tail -n +11 | head -n1 >> log/proc4.log
  cat top.temp | tail -n +12 | head -n1 >> log/proc5.log
  sleep 1s
done

rm free.temp
rm top.temp