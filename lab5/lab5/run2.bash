./follower.bash &
PID=$!

./mem.bash &
PID1=$!
./mem2.bash &
PID2=$!

wait $PID1 $PID2
kill $PID