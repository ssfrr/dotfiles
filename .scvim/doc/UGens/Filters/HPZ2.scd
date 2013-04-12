HPZ2					two zero fixed highpass

Inherits from: Object : AbstractFunction : UGen : Filter : LPZ2

HPZ2.ar(in, mul, add)
HPZ2.kr(in, mul, add)


A special case fixed filter. Implements the formula:

out(i) = 0.25 * (in(i) - (2*in(i-1)) + in(i-2))

See also: HPZ1

// Compare:

{ WhiteNoise.ar(0.25) }.play;

{ HPZ2.ar(WhiteNoise.ar(0.25)) }.play;

// HPZ2 is useful to detect changes in a signal:
// see also HPZ1
(
{ 	
	var changingSignal = LFNoise0.ar(1000); 
	var hpz1 = HPZ2.ar(changingSignal);
	[hpz1, hpz1 > 0] 
}.plot
);


