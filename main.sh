#!/bin/bash

# Settings:
port=8080
fifo=/tmp/fifo

# functions
send_response() {

    if [[ ! "$method" == GET ]]; then
        echo "HTTP/1.1"
        echo "Content-Type: text/html"
        echo "Status: 405 method not supported"
        echo
        echo "<html><img src='https://http.cat/405' /></html>"
        return
    fi

    echo "HTTP/1.1"
    echo "Content-Type: text/html"
    echo
    echo "<html><h1>$(date)</h1></html>"
} 

read_request_then_respond() {
    local method=""
    local uri=""
    local host=""

    while read line; do
        if [[ "$line" == GET* ]]; then
            echo "$line" >&2
            read method uri extra <<< "$line"
        fi

        if [[ "$line" == Host:* ]]; then
            read extra host <<< "$line"
        fi

        if [[ "$line" == $'\r' ]]; then
            break
        fi
    done

    send_response

    killall nc
}

rm -f $fifo 
mkfifo $fifo 

while true; do
    cat $fifo | nc -l $port | read_request_then_respond  > $fifo
done
