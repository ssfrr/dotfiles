Messages 

Sending messages is the way things get done in an object oriented language. A message consists of a message selector which names the type of operation, a receiver to which the message is sent and in some cases a list of arguments which give additional information pertaining to the operation. A message always
returns a result. The kind of result depends on the kind of message. In the default case, the return value is the receiver itself.

Messages may be written using binary operators, functional notation or receiver notation. 

Binary operator messages

A binary operator selector is any string of characters from the list of legal binary operator characters:

	! @ % & * - + = | < > ? /

An exception is that no operator may begin with // or /* which are comment delimiters.

A binary operator expression consists of two expressions with a binary operator between them. 

	1 + 2		// sum of one and two

	a - b		// difference of a and b

	x < 0.0		// answer whether x is less than zero

A binary operator can also be an identifier followed by a colon.

	10 rrand: 100
	
Operator Precedence

There is none. All binary operators have the same level of precedence and associate from left to right. 
For example, the expression:

		a * b + c * d

	is equivalent to:

		((a * b) + c) * d

	and not:

		(a * b) + (c * d)
		
Therefore it is usually better style to fully parenthesize your expressions.

Functional notation messages

The message selector preceeds the parenthesized argument list. The first argument in the list is actually 
the receiver.

	sin(x)		// sine of x
	
	max(a, b)		// maximum of a and b


Receiver notation messages

A method call in functional notation may be converted to receiver notation by putting the receiver before the method name followed by a dot as shown below. 

	max(a, b)    is equivalent to :   a.max(b)
	sin(x)    is equivalent to :   x.sin
	
	another example:

		g(f(a, b), c) 

	is equivalent to :

		g(a.f(b), c)

	is equivalent to :

		f(a, b).g(c)

	is equivalent to :

		a.f(b).g(c)


Default Argument Values

You may call a function or method with more or fewer arguments than it was declared to accept. If fewer arguments are passed, those arguments not passed are set to a default value if one is given in the method or function definition, or otherwise to nil.  If too many arguments are passed, the excess arguments are either collected into an Array or ignored depending on whether or not the function or method has an ellipsis argument (explained in Functions). When calling a method or function with zero arguments you can omit the parentheses:

// x is declared to take two arguments a and b which default to 1 and 2 respectively.
// It returns their sum. This syntax will be explained in the section on Functions.
x = { arg a=1, b=2; a + b }; 

z = x.value;    		// z is set to 3. (a defaults to 1, b defaults to 2)

z = x.value(10);		// z is set to 12. (a is 10, b defaults to 2)

z = x.value(10, 5);	// z is set to 15. (a is 10, b is 5)

z = x.value(10, 5, 9);	// z is set to 15. (a is 10, b is 5, 9 is ignored)


Keyword Arguments

Arguments to Methods may be specified by the name by which they are declared in a method's definition. Such arguments are called keyword arguments. Any argument may be passed as a keyword argument except for the receiver 'this'. Keyword arguments must come after any normal (aka 'positional') arguments, and may be specified in any order. If a keyword is specified and there is no matching argument then it is ignored and a warning will be printed. This warning may be turned off globally by making the following call: 

keywordWarnings(false)

If a keyword argument and a positional argument specify the same argument, then the keyword argument value overrides the positional argument value.

For example the 'ar' class method of the SinOsc class takes arguments named freq, phase, mul, and add in that order. All of the following are legal calls to that method.

SinOsc.ar(800, pi, 0.2, 0); // all normal arguments: freq, phase, mul, add

// freq = 800, mul = 0.2, others get default values.
SinOsc.ar(800, mul: 0.2); 

// freq = 800, phase = pi, mul = 0.2, add gets its default value of zero.
SinOsc.ar(phase: pi, mul: 0.2, freq: 800);

// keyword value of 1200 overrides the positional arg value of 800
SinOsc.ar(800, freq: 1200); 

SinOsc.ar(zorg: 999); // invalid keyword prints warning

The arguments to a Function may also be specified by keyword arguments when using the 'value' message. 

// function args may be specified by keyword.
{ arg a=1, b=2, c=3; [a, b, c].postln }.value(b: 7, c: 8);

You may also use keyword arguments when using the 'perform' method.

SinOsc.perform('ar', phase: pi, mul: 0.2, freq: 800);

Cost of using keyword arguments

When using keyword arguments there is a runtime cost to do the matching that you should be aware of. The cost can be worth the convenience when speed is not critical.


