
echo -e "HTTP/1.1 200 OK\r\n$(date)\r\n\r\n" > /index.html
echo -e "<html><head>" >> /index.html
echo -e "<title>Docker on Demand</title>" >> /index.html
echo -e "<meta http-equiv="refresh" content=\"$CLIENT_REFRESH_SECS\" >" >> /index.html
echo -e "</head><body>" >> /index.html
echo -e "<p>Wait $CLIENT_REFRESH_SECS seconds while your server is loading, your server will be available for $CONTAINER_LIFETIME .....</p>" >> /index.html
echo -e "</body></html>" >> /index.html

nc -l -p $LISTEN_PORT < /index.html

myself=$(cat /proc/self/cgroup |grep "cpu"|cut -d'/' -f3|head -n1)

# 1. stop this container ( auto die after echo )
# 2. run selected command
# 3. sleep until time to kill target
# 4. run selected command
# 5. restart docker on demand 

echo "sleep 1s ; $HOST_COMMAND_ON_START ; ( sleep $CONTAINER_LIFETIME ; $HOST_COMMAND_ON_STOP ; docker start $myself ) & " > $FIFO_PATH
