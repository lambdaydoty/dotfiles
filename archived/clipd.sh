while [ true ]; do
  nc -l 3001 | tee /dev/tty | putclip
done
