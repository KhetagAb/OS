let N=$1
let step=0
declare -a array

while true; do
  for i in 1 2 3 4 5 6 7 8 9 10; do
    array+=(i)
  done

  if (( ${#array[@]} > N ))
  then
    exit 0
  fi
done