# Docker-on-demand
Docker container that listen for connection on http port and run command on host. It can be used to start or stop a parent container ( after a given time ).

Scene
-----
You have a big container/stack that consumes a lot of memory and dont need to be running 24x7.


Running
-------

NOTE: D.o.d. and target must be on same host.

Run listener on host

    ./files/host-listener.sh &

Start docker on demand using variables do define target container and target port.

        docker run -p 8081:8081 -e LISTEN_PORT=8081 -e CLIENT_REFRESH_SECS=60 -e HOST_COMMAND_ON_START="docker start 429c28e5e606" -e HOST_COMMAND_ON_STOP="docker stop 429c28e5e606" -v /tmp/pipe-dod:/pipe -d -e CONTAINER_LIFETIME=5m -it drecchia/docker-on-demand:1.0.0

Now when a http request is made at port 8081:

    1. the d.o.d. container will die
    2. host-listener will run $HOST_COMMAND_ON_START 
    3. host-listener will fork a sleep thread waiting for $CONTAINER_LIFETIME
    4. on timeout host-listener will run $HOST_COMMAND_ON_STOP
    5. whe d.o.d. container will be started again.

