AbstractFunction

Inherits from: Object

An AbstractFunction is an object which responds to a set of messages that represent
mathematical functions. Subclasses override a smaller set of messages to respond
to the mathematical functions. The intent is to provide a mechanism for functions
that do not calculate values directly but instead compose structures for calculating.

Function, Pattern, Stream and UGen are subclasses of AbstractFunction.
For example, if you multiply two UGens together the receiver responds by answering a new
instance of class BinaryOpUGen which has the two operands as inputs.

see also: UGen, Pattern, Function

Unary Messages:

All of the following messages send the message composeUnaryOp to the receiver with the
unary message selector as an argument. See: UnaryOpFunction

neg, reciprocal, bitNot, abs, asFloat, asInt, ceil, floor, frac, sign, squared, cubed, sqrt
exp, midicps, cpsmidi, midiratio, ratiomidi, ampdb, dbamp, octcps, cpsoct, log, log2,
log10, sin, cos, tan, asin, acos, atan, sinh, cosh, tanh, rand, rand2, linrand, bilinrand,
sum3rand, distort, softclip, nyqring, coin, even, odd, isPositive, isNegative,
isStrictlyPositive, rho, theta



Binary Messages:

All of the following messages send the message composeBinaryOp to the receiver with the
binary message selector and the second operand as arguments. See:  BinaryOpFunction

+, -, *, /, div, %, **, min, max, <, <=, >, >=, &, |, lcm, gcd, round, trunc, atan2, 
hypot, hypotApx, >>, +>>, fill, ring1, ring2, ring3, ring4, difsqr, sumsqr, sqrdif, absdif, amclip,
scaleneg, clip2, excess, <!, rrand, exprand, rotate, dist, bitAnd, bitOr, bitXor, bitHammingDistance, @



Messages with more arguments:

All of the following messages send the message composeNAryOp to the receiver with the
binary message selector and the other operands as arguments. See NAryOpFunction

clip, wrap, fold, blend, linlin, linexp, explin, expexp


applyTo(... args)

Interface that allows us to combine selectors (Symbols) and Functions. Sends valueArray(args) to this.

// example:

f = [{ |a, b| a * b * 100.rand }, { |a, b| sin(a) * sin(b) }, '*', '/'];
f.choose.postcs.applyTo(3, 4);

// this is used in SequenceableCollection reduce:
(1..10).reduce('+');
(1..10).reduce({ |a, b| a * b * 1.0.rand });

asUGenInput(for)

returns the result of sending the value(for) message to this.

// example:
(
var f, g, product;
f = { SinOsc.ar(400) };
g = { LFPulse.kr(8)  };
product = f * g * 0.1;
{ Pan2.ar(product, SinOsc.kr(0.3)) }.play; 
)

sampled (function, n, from, to)
	

//sample a function
f = { |x| sin(3*x)*cos(8*x) }
f.plotGraph2(from:0,to:2);
f.sampled(10,0,2).plotGraph2(from:0,to:2);
f.sampled(80,0,2).plotGraph2(from:0,to:2);

//on complicated functions a sampled function is less cpy heavy.
f = { |x| 60.collect{ 2**((x-rrand(0.0,1.0))) }.sum/60 };
f.plotGraph2(from:0,to:1);
g = f.sampled(200);
g.plotGraph2(from:0,to:1);
{ 200.collect{ f.(rand(0.0,1.0)) } }.bench;
{ 200.collect{ g.(rand(0.0,1.0)) } }.bench;

Function Composition:

when unary, binary or n-ary operators are appied to an abstract function, it returns an object that represents
this operation, without evaluating the function: UnaryOpFunction, BinaryOpFunction, NAryOpFunction.
Note that different subclasses like Pattern or UGen have their own composition scheme analogous to the one of AbstractFunction itself. More about functions, see Function


// examples

a = { 1.0.rand } + 8;
a.value;


y = { 8 } + { 1.0.rand };
y.value;

// arguments are passed into both functions

y = { |x=0| x } + { 1.0.rand };
y.value(10);


y = { |x=0| x * 3 } + { |x=0| x + 1.0.rand };
y.value(10);

y.postcs;

y = { |x=0| x * 3 } + { |x=0| x + 1.0.rand } * { |x=0| [50, 100].choose + x } + 1.0;
y.value(10);

// environments can be used as a lookup with valueEnvir:

(
Environment.use {
	~y = 10;
	~x = 2;
	~z = { |x=8| x } + { |y=0| y + 1.0.rand };
	~z.valueEnvir;
}
)

// n-ary operators:

a = blend({ 3.0.rand }, { 1000.rand }, { |frac| frac });
a.value(0.5);

a.value((0, 0.06..1)); // creates a range of values..











