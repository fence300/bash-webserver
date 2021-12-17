#!/bin/bash




echo "HTTP/1.1"

case "$uri" in
    (/)
        echo "Content-Type: text/html"
        echo 
        echo "<html>"
        echo "<head>"
        echo "<title>Parasite</title>"
        echo "</head>"
        echo "<body>"
        echo "<div style='max-width: 800px; margin: auto;'>"
        echo "<h1>Hello</h1>"
        echo "<hr/>"
        echo "<p>This is the home page</p>"
        echo "</div>"
        echo "</body>"
        echo "</html>"
    ;;
esac
