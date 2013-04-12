BinaryOpUgen		apply a binary operation to the values of an input ugen

BinaryOpUGens are created as the result of a binary operator applied to a UGen. 

	(SinOsc.ar(200) * ClipNoise.ar).dump;
	(SinOsc.ar(200).thresh(0.5)).dump;

The use of the binary operators * and thresh above each instantiate a BinaryOpUGen. The operators themselves  (which are methods) are not to be confused with the resulting BinaryOpUGen (which is an object). 
When operating on UGens instead of numbers, what results is not a result of the calculation, but a structure that represents that calculation. For the immediate operations on numbers, see for example SimpleNumber.

There are helpfiles for each the different operators, listed below. Examples for unary operations on UGens are to be found in UGen's superclass AbstractFunction.

The following operators have their own helpfiles:

+ - * / ** absdif amclip atan2 clip2 difsqr excess fold2 hypot hypotApx max min ring1 ring2 ring3 ring4 round scaleneg sqrdif sqrsum sumsqr thresh trunc wrap2

	*new(selector, a, b)		return a new instance that applies the operator (selector) 
						to the ugens (a and b)
						normally, this is implicitly called when applying a unary operator to a UGen.

See also: UnaryOpUGen
Structually related: BinaryOpFunction, Pbinop

Examples
	
	a = WhiteNoise.ar; // a WhiteNoise
	b = a + 2; // a BinaryOpUGen.
	b.operator; // +

	// sound example
	(
	{ 
		var a = LFSaw.ar(300);
		var b = LFSaw.ar(329.1);
		a % b * 0.1 
	}.play;
	)	

The comparison operators

The operators >, >=, <, and <= are particularly useful for triggering. They should not be confused with their use in conditionals. Compare

if(1 > 0) { "1 is greater than 0".postln }; // > returns a boolean

with

// trigger an envelope
(
{
	var trig;
	trig = SinOsc.ar(1) > 0.1;
	EnvGen.kr(Env.perc, trig, doneAction: 0) * SinOsc.ar(440,0,0.1)
}.play
) // > outputs 0 or 1

See the individual helpfiles ( >, >=, <, <= ) for more detail.

Since the equality operator (==) is used to distingush objects including UGens, it cannot be used to create a BinaryOpUGen by application. Instead, to get a trigger value each time two signals are the same (instead of just finding out whether two UGens are the same), one can instantiate a BinaryOpUGen directly:

	(
	{
		var a = SinOsc.ar(1).round(0.1);
		var b = SinOsc.ar(1.2).round(0.1);
		BinaryOpUGen('==', a, b) * 0.1
	}.play;
	)
	
	
	


