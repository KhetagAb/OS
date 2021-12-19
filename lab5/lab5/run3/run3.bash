./follower.bash &
PID=$!

#1.530 - 1.560
let N=1530000
declare -a pids

for (( i = 0; i < 30; i++ )); do
  ./newmem.bash $N &
  pids+=($!)
  sleep 1s
done

for pid in ${pids[@]}; do
  wait $pid
done

kill $PID