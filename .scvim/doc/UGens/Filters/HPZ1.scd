HPZ1					two point difference filter

Inherits from: Object : AbstractFunction : UGen : Filter : LPZ1

HPZ1.ar(in, mul, add)
HPZ1.kr(in, mul, add)

A special case fixed filter. Implements the formula:

out(i) = 0.5 * (in(i) - in(i-1))

which is a two point differentiator.

See also: HPZ2

// Compare:

{ WhiteNoise.ar(0.25) }.play;

{ HPZ1.ar(WhiteNoise.ar(0.25)) }.play;

// HPZ1 is useful to detect changes in a signal:
// see also HPZ2
(
{ 	
	var changingSignal = LFNoise0.ar(1000); 
	var hpz1 = HPZ1.ar(changingSignal);
	[hpz1, hpz1 > 0, hpz1.abs > 0] 
}.plot
);



