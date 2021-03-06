Functions

See also: Function, AbstractFunction, FunctionDef

A Function is an expression which defines operations to be performed when it is sent the 'value' message. In functional languages, a function would be known as a lambda expression. Function definitions are enclosed in curly brackets {}. Argument declarations, if any, follow the open bracket. Variable declarations follow argument declarations. An expression follows the declarations. 

{ arg a, b, c;  var d;   d = a * b; c + d }

Functions are not evaluated immediately when they occur in code, but are passed as values just like integers or strings.

A function may be evaluated by passing it the value message and a list of arguments.

When evaluated, the function returns the value of its expression.

f = { arg a, b; a + b };
f.value(4, 5).postln;
f.value(10, 200).postln;

An empty function returns the value nil when evaluated.

{}.value.postln;

A function can be thought as a machine able to perform a task on demand, e.g. a calculator. The calculator can receive input (args) and can output a value, the result of the performed operations. The function definition can then be thought as the building of the calculator: once built, the calculator does nothing until it is requested to work (by passing the value method to a function).
The following figure depicts an empty function, input without output, output without input, and the general case with input and output. 
 
		
								Functions

Arguments

An argument list immediately follows the open curly bracket of a function definition. An argument list either begins with the reserved word arg, or is contained between two vertical bars. If a function takes no arguments, then the argument list may be omitted. 

Names of arguments in the list may be initialized to a default value by using an equals sign. Arguments which are not explicitly initialized will be set to nil if no value is passed for them.

If the last argument in the list is preceeded by three dots (an ellipsis), then all the remaining arguments that were passed will be assigned to that variable as an Array. Arguments must be separated by commas.

examples:

arg a, b, c=3; // is equivalent to:

|a, b, c=3|

arg x='stop', y, z=0; // these args are initialised

arg a, b, c ... d; // any arguments after the first 3 will be assigned to d as an Array


If you want all the arguments put in an Array

arg ... z;

In general arguments may be initialized to literals or expressions, but in the case of Function-play or SynthDef-play, they may only be initialized to literals.

// this is okay:

{ arg a = Array.geom(4, 100, 3); a * 4 }.value;

// this is not:

{ arg freq = Array.geom(4, 100, 3); Mix(SinOsc.ar(freq, 0, 0.1)) }.play; // silence

// but this is:
{ arg freq =  #[ 100, 300, 900, 2700 ]; Mix(SinOsc.ar(freq, 0, 0.1)) }.play; // silence

See Literals for more information.

Variables

Following the argument declarations are the variable declarations. These may be declared in any order. Variable lists are preceeded by the reserved word var. There can be multiple var declaration lists if necessary. Variables may be initialized to default values in the same way as arguments. Variable declarations lists may not contain an ellipsis.

examples:

var level=0, slope=1, curve=1;





