#!/bin/bash

./loopScript.sh&pid1=$!
./loopScript.sh&pid2=$!
./loopScript.sh&pid3=$!

cpulimit -z -p $pid1 -l 10