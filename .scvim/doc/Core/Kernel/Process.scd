Process

superclass: Object

A Process is the runtime environment for the virtual machine and interpreter.
It has a subclass named Main which is where you should override the methods
of Process. There are two methods of interest. One is named 'startup' and is 
called after the class library has been compiled. The other is named 'run' and
is called when the user chooses the Run menu command.

startup

called after the class library has been compiled. Override this in class Main to do whatever you want.

run

called when the user chooses the Run menu command. Override this in class Main to do whatever you want.

*tailCallOptimize

Returns a Boolean indicating whether tail call optimization is on. The default is on.

*tailCallOptimize_(aBoolean)

Turns tail call optimization on or off. Setting this to false can help with debugging by including intermediate levels in an error backtrace.


