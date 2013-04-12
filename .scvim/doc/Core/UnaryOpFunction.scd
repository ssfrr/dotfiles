UnaryOpFunction	represent a unary oparation on a function

superclass: AbstractFunction

Operating on functions instead of numbers, what results is not a result of the calculation, but a structure that represents that calculation.

// example
a = 2.sqrt; // result is square root of two (approximate floating point).
a = { b }.sqrt; // result is  a UnaryOpFunction
b = 2;
a.value; // now it is evaluated, and the result is calculated
b = 9;
a.value; // again, with a different value.

see also: BinaryOpFunction, NAryOpFunction
related: UnaryOpStream, Punop


// sound example
(
var a = { 19.rand };
var b = a.sqrt;
fork {
	15.do {
		(instrument: \default, note: [a.value, b.value]).play;
		0.3.wait;
	}
}
)


