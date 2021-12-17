#!/bin/bash

tag() { echo "<$1>$2</$1>";}
h1() { tag h1 "$1";}
p() { tag p "$1";}

echo "HTTP/1.1"

case "$uri" in
    (/)
        echo "Content-Type: text/html"
        echo 
        echo "<html>"
        echo "<head>"
        tag title Parasite
        echo "</head>"
        echo "<body>"
        echo "<div style='max-width: 800px; margin: auto;'>"
        h1 Hello
        echo "<hr/>"
        p This is the home page
        echo "</div>"
        echo "</body>"
        echo "</html>"
    ;;
esac
