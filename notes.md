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

# Stage 3
### What's going on in this example
You may notice that the actionable code in `main.sh` became a lot more complicated.  Let's break it down.
- These `{ curly brackets }` define an anonymous function in bash.  That is to say, all of the logic inside of them will be grouped together.
- The first set of curly brackets outputs a very simple webpage response.
- The pipe at the end of the curly brackets redirects all output on STDOUT to be read as input on STDIN by the `nc` command
- The `nc` command will send that input as a response to the next incoming request.
- The pipe after the `nc` command will cause the next anonymous function to read the output from `nc` as input
- The while loop will process each line
- When the while loop reads a line that contains only a carriage return, it will break and stop reading lines.
- The next thing that the second anonymous function does after the while-loop detects the end of the meaningful request is to `killall nc` which will close the connection
- If you do not close the connection by ending the listening `nc` process, then the browser may simply hang and eventually time out even though it received a response.

# Stage 4
### What's changed since stage 3
This change is actually relatively minor. Remember how a series of commands enclosed in `{ curly brackets }` is an anonymous function?  Well, the functions are not anonymous anymore.  

We have added a section after `settings` but before the actionable logic part of the script where we assign these logic blocks to a name.  And then, when it is time to execute that logic, we just call those functions by name and the code defined in curly brackets will be executed.

You should be able to observe the same behavior when you execute the example, even though we have rearranged the logic and given it a name that tells us what each function is doing.