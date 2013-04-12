UnaryOpUGen		apply a unary operation to the values of an input ugen

UnaryOpUGens are created as the result of a unary operator applied to a UGen. 

	(SinOsc.ar(200).abs).dump;
	(LFSaw.ar(200).sin).dump;
	
As in the examples given here, you don't usually need to instantiate UnaryOpUGen youself. 
Examples for unary operations on UGens are to be found in UGen's superclass AbstractFunction. They include: neg, abs, ceil, floor, frac, squared, cubed, sqrt, exp, log, log2, log10, sin, cos, scurve, distort

	*new(selector, a)		return a new instance that applies the operator (selector) to the ugen (a)

See also: BinaryOpUGen
Structurally related: UnaryOpFunction, Punop

Examples	
	
	a = WhiteNoise.ar; // a WhiteNoise
	b = a.squared; // a UnaryOpUGen.
	b.operator; // squared
	
	// sound example
	
	{ var a = LFSaw.ar(300).range(0, 2pi); a.sin * 0.1 }.play;
	
	// Plotting the "abs" unary operator (via the server):
	
	{ SinOsc.ar(300).abs }.plot
	


