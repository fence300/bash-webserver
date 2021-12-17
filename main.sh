#!/bin/bash

# Settings:
port=8080


{
    echo "HTTP/1.1"
    echo "Content-Type: text/html"
    echo
    echo "<html><h1>$(date)</h1></html>"
} | nc -l $port | {
    while read line; do
        if [[ "$line" == $'\r' ]]; then
            break
        fi
    done

    killall nc
}