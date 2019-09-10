while [ true ]; do
  nc -l 2000 | tee /dev/tty | putclip
done
