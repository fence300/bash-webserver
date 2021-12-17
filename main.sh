#!/bin/bash

# Settings:
port=8080
fifo=/tmp/fifo

# functions
send_response() {
    echo "HTTP/1.1"
    echo "Content-Type: text/html"
    echo
    echo "<html><h1>$(date)</h1></html>"
} 

read_request_then_respond() {
    while read line; do
        if [[ "$line" == $'\r' ]]; then
            break
        fi
    done

    send_response

    killall nc
}

while true; do
    cat $fifo | nc -l $port | read_request_then_respond  > $fifo
done
