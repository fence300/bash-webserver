#!/bin/bash

# Settings:
port=8080
fifo=/tmp/fifo



# load hosts configurations
declare -A hosts=()

hosts["parasite"]="./parasite.sh"


## Functions


default_response() {
    echo "HTTP/1.1"
    echo "Content-Type: text/html"
    echo
    echo "<html>"
    echo "<h1>Default response</h1>"
    echo "<h1>Date: $(date)</h1>"
    echo "<hr/>"
    echo "<p>$1</p>"
    echo "</html>"    
}

send_response() {

    if [[ ! "$method" == GET ]]; then
        echo "HTTP/1.1"
        echo "Content-Type: text/html"
        echo "Status: 405 method not supported"
        echo
        echo "<html><img src='https://http.cat/405' /></html>"
        return
    fi

    if [[ -z "$host" ]]; then
        default_response "Somehow, your Host header was blank"
        return
    fi

    if [[ -z "${hosts[${host%:*}]}" ]]; then
        default_response "The website you requested is not configured on this server"
        return 
    fi

    if [[ ! -s "${hosts[${host%:*}]}" ]]; then 
        default_response "The website you requested does not have a valid configuration file"
        return 
    fi

    env uri="$uri" host="$host" bash "${hosts[${host%:*}]}"
    return 
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
