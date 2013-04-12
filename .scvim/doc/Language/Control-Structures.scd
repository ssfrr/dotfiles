Control Structures

Control structures in SuperCollider are implemented via message sends. Here are a few of those available. 
See Syntax-Shortcuts for the various ways expressions can be written.



If

Conditional execution is implemented via the if message. The if message is sent to an expression which must return a Boolean value. In addition it takes two arguments: a function to execute if the expression is true and another optional function to execute if the expression is false. The if message returns the value of the function which is executed. If the falseFunc is not present and the expression is false then the result of the if message is nil.

syntax:

if (expr, trueFunc, falseFunc);
..or..
expr.if (trueFunc, falseFunc);


see also: the if helpfile

examples:

if ( [false, true].choose,				// Boolean expression (chooses one at random)
	{ "expression was true".postln },	// true function
	{ "expression was false".postln }	// false function
)

(
var a = 1, z;
z = if (a < 5, { 100 },{ 200 });
z.postln;
)

(
var x;
if (x.isNil, { x = 99 });
x.postln;
)

'If' expressions are optimized (i.e. inlined) by the compiler if they do not contain variable declarations in the trueFunc and the falseFunc.





While

The while message implements conditional execution of a loop. If the testFunc answers true when evaluated, then the bodyFunc is evaluated and the process is repeated. Once the testFunc returns false, the loop terminates.

syntax:

while ( testFunc, bodyFunc );
..or..
testFunc.while( bodyFunc );

example:

(
i = 0;
while ( { i < 5 }, { i = i + 1; "boing".postln });
)

'While' expressions are optimized by the compiler if they do not contain variable declarations in the testFunc and the bodyFunc.



For

The for message implements iteration over an integer series from a starting value to an end value stepping by one each time. A function is evaluated each iteration and is passed the iterated numeric value as an argument.

syntax:

for ( startValue, endValue, function )
..or..
startValue.for ( endValue, function )

example:

for (3, 7, { arg i; i.postln }); // prints values 3 through 7



ForBy

The forBy selector implements iteration over an integer series with a variable step size. A function is evaluated each iteration and is passed the iterated numeric value as an argument.

syntax:

forBy ( startValue, endValue, stepValue, function );
..or..
startValue.forBy ( endValue, stepValue, function );


example:

forBy (0, 8, 2, { arg i; i.postln }); // prints values 0 through 8 by 2's



Do

Do is used to iterate over a collection. Positive Integers also respond to 'do' by iterating from zero up to their value. Collections iterate, calling the function for each object they contain. Other kinds of Objects respond to do by passing themselves to the function one time. The function is called with two arguments, the item, and an iteration counter.

syntax:

do ( collection, function )
..or..
collection.do(function)

example:

[ 1, 2, "abc", (3@4) ].do({ arg item, i; [i, item].postln; });

5.do({ arg item; item.postln }); // iterates from zero to four

"you".do({ arg item; item.postln }); // a String is a collection of characters

'they'.do({ arg item; item.postln }); // a Symbol is a singular item

(8..20).do({ arg item; item.postln }); // iterates from eight to twenty 

(8,10..20).do({ arg item; item.postln }); // iterates from eight to twenty, with stepsize two

Routine({ var i=10; while { i > 0 } { i.yield; i = i - 5.0.rand } }).do({ arg item; item.postln });

Note: The syntax (8..20).do uses an optimization to avoid generating an array that is used only for iteration (but which would be discarded thereafter). The return value of (8..20).do({ |item| item.postln }) is 8, the starting value.

(8..20) do: { |item| item.postln } is not optimized, and returns the array.


Switch

Object implements a switch method which allows for conditional evaluation with multiple cases. These are implemented as pairs of test objects (tested using if this == test.value) and corresponding functions to be evaluated if true. The switch statement will be inlined if the test objects are all Floats, Integers, Symbols, Chars, nil, false, true and if the functions have no variable or argument declarations. The inlined switch uses a hash lookup (which is faster than nested if statements), so it should be very fast and scale to any number of clauses.


(
var x=0; //also try 1
switch(x,0,{"hello"}, 1, {"goodbye"})
)


(
var x, z;
z = [0, 1, 1.1, 1.3, 1.5, 2];
switch (z.choose.postln,
	1,   { \no },
	1.1, { \wrong },
	1.3, { \wrong },
	1.5, { \wrong },
	2,   { \wrong },
	0,   { \true }
).postln;
)

or:
		
(
var x, z;
z = [0, 1, 1.1, 1.3, 1.5, 2];
x = switch (z.choose)
	{1}   { \no }
	{1.1} { \wrong }
	{1.3} { \wrong }
	{1.5} { \wrong }
	{2}   { \wrong }
	{0}   { \true };
x.postln;
)

Case

Function implements a case method which allows for conditional evaluation with multiple cases. Since the receiver represents the first case this can be simply written as pairs of test functions and corresponding functions to be evaluated if true. Case is inlined and is therefore just as efficient as nested if statements.

(
var i, x, z;
z = [0, 1, 1.1, 1.3, 1.5, 2];
i = z.choose;
x = case
	{ i == 1 }   { \no }
	{ i == 1.1 } { \wrong }
	{ i == 1.3 } { \wrong }
	{ i == 1.5 } { \wrong }
	{ i == 2 }   { \wrong }
	{ i == 0 }   { \true };
x.postln;
)


Other Control Structures

Using Functions, many control structures can be defined like the ones above. In the class Collection there are many more messages defined for iterating over Collections.



