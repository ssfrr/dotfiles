Pipe

superclass: UnixFILE

Pipe stdin to, or stdout from, a unix shell command. Pipe treats the shell command as if it were a UnixFILE, and returns nil when done. See UnixFILE for details of the access methods. Pipe must be explicitly closed. Do not rely on the garbage collector to do this for you!


Note: For anyone still using OS X 10.3, unix commands like pipe do not work when the server is booted; quit the server, otherwise sc crashes. More recent OS X is not affected. 


*new(commandLine, mode)

	commandLine - A String representing a valid shell command.
	mode - A string representing the mode. Valid modes are "w" (pipe to stdin) and "r" (pipe from stdout).
	
close
	Closes the pipe. You must do this explicitly before the Pipe object is garbage collected.
	
Examples
	
// quit the server
s.quit;

// this pipes in stdout from ls
(
var p, l;
p = Pipe.new("ls -l", "r");						// list directory contents in long format
l = p.getLine;								// get the first line
while({l.notNil}, {l.postln; l = p.getLine; });	// post until l = nil
p.close;										// close the pipe to avoid that nasty buildup
)


A more time-intensive request:
(
var p, l;
p = Pipe.new("ping -c10 sourceforge.net", "r");						// list directory contents in long format
l = p.getLine;								// get the first line
while({l.notNil}, {l.postln; l = p.getLine; });	// post until l = nil
p.close;										// close the pipe to avoid that nasty buildup
)




