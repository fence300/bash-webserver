#!/bin/bash

# Settings:
port=8080


nc -l $port | while read line; do
    echo -e "\e[92m#$line\e[0m"
    echo "$line" | hexdump
done 