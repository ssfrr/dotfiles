Interpreter

superclass: Object

The interpreter defines a context in which interactive commands are compiled and executed.

In the interpreter, this refers to the interpreter itself, e.g.:

this.postln


Accessing

The interpreter defines instance variables 'a' through 'z' which are always available in the interpreter. By convention, the variable 's' is used to hold the default Server. Assigning another value to 's' may cause some of the examples in the documentation to fail. 

clearAll

set the values of the variables 'a' through 'z' to nil.

(
x = 123;
x.postln;
this.clearAll;
x.postln;
)


Compile & Interpret

interpret(aString)

Compile and execute a String.

this.interpret("(123 + 4000).postln");

interpretPrint(aString)

Compile and execute a String, printing the result.

this.interpretPrint("123 + 4000");


compile(aString)

Compile a String and return a Function.

(
z = this.compile("(123 + 4000).postln");
z.postln;
z.value;
)

compileFile(pathName)

Reads the file at pathName, compiles it and returns a Function. 
The file must contain a valid SuperCollider expression, naturally.
This will not compile class definitions, only expressions.

executeFile(pathName)

Reads the file at pathName, compiles it and executes it, returning the result. 
The file must contain a valid SuperCollider expression, naturally.
This will not compile class definitions, only expressions.

cmdLine

Returns the previosly interpreted code.

(
1 + 2;
this.cmdLine
)

codeDump

this interpreter variable can be set to evaluate a function with any sucessfully compiled code.
see e.g. the class History.

a = [ ]; // store all the code evaulated in a
this.codeDump = { |code| a = a.add(code) };
1 + 3;
f = { "hallo" };
a.postcs;
codeDump = nil; // reset to nil.


preProcessor

can be used to modify code before it is interpreted. Given appropriate delimiters, this can be used to implement little languages.

// silly but simple: understand a Saw for every SinOsc
this.preProcessor = { |code| code.replace("SinOsc", "Saw") };

{ SinOsc.ar(200) * 0.1 }.play;

preProcessor = nil; // reset to nil.





