# Stage 1
### The file main.sh contains:
- A section where you can set the port that it will listen on
- The command to listen for an incoming connection
### How to run this example
- clone the repository to a linux server with the `nc` command installed
- checkout to the branch `stage-1`
- run `bash ./main.sh`
- the `nc` process is now listening for incoming requests on all available IP addresses, on whatever port you selected (by default, 8080)
- if you are running this locally on a linux desk top, you can open a browser and visit http://localhost:8080/
- if you are running this on a remote server which you can access via IP address, you can visit http://IP.AD.DR.ESS:8080/


Your browser request will time out, because this `nc` command is not configured to return any response. We'll get there in stage 3.  The thing I want you to notice from this exercise is that the nc command generates output when it receives a request.  That output is literally the text of the request that it received from the browser.  And that request concludes meaningful information by sending a blank line -- or so it seems...

# Stage 2
### changes in main.sh:
We still have the `nc` command listening on whatever port you set in the settings section. But now, each line of input is read into a while loop and `echo`ed into the command `hexdump`


### How to run this example
- basically the same as before
- clone the repository to a linux server with the `nc` command installed, if you haven't already
- checkout to the branch `stage-2`
- run `bash ./main.sh`
- send a request to `nc` in a browser and look for `nc` to generate output, only this time the output will be the line in green and preceded by a `#` and followed by a hexdump of that line


This stage is to show you that the blank line at the end of meaningful output is not really blank.  Before the newline character which `read` will interpret as the end of the line, there is another invisible character -- a carriage return.

# 

