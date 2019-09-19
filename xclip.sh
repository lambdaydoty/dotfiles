while read l
do
  echo "$l" | nc -N localhost 3000
  echo "$l" | nc -N localhost 4000
done
