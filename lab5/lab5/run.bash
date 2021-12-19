./follower.bash &
PID=$!

./mem.bash &
PID1=$!

wait $PID1
kill $PID