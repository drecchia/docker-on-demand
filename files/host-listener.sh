#!/bin/bash

pipe=/tmp/pipe-dod

trap "rm -f $pipe" EXIT

if [ ! -p $pipe ]; then
    rm -rf $pipe
    mkfifo $pipe
fi

while true
do
    if read line <$pipe; then
        if [ "$line" = "quit" ]; then
            break
        fi

	tag=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1)
	script="/tmp/pipework-${tag}.sh"
        echo $line > $script && chmod +x $script 
	$script
	rm $script
    fi
done

echo "Reader exiting"
