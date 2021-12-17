#!/bin/bash

# Settings:
port=8080

# functions
send_response() {
    echo "HTTP/1.1"
    echo "Content-Type: text/html"
    echo
    echo "<html><h1>$(date)</h1></html>"
} 

read_request() {
    while read line; do
        if [[ "$line" == $'\r' ]]; then
            break
        fi
    done

    killall nc
}

send_response | nc -l $port | read_request
