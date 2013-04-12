Pgeom			geometric series pattern

superclass: Pattern

Pgeom(start, grow, length)

Returns a stream that behaves like a geometric series. 

start - start value  (default: 1.0)
grow - multiplication factor.  (default: 1.0)
length - number of values produced (default: inf)


See also: Pseries


// example

(
var a;
a = Pgeom(1.0, 1.1, inf);
a.asStream.nextN(100).plot;
)


// sound example
(
SynthDef(\help_sinegrain, 
	{ arg out=0, freq=440, sustain=0.05, amp=0.1;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2, amp), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).add;
)


(
var a;
a = Pgeom(300, 1.03, 70).asStream;
{
	a.do { |val|
		Synth(\help_sinegrain, [\freq, val]);
		0.02.wait;
	}
}.fork;
)

(
Pbind(
	\dur, 0.01,
	\instrument, \help_sinegrain,
	\freq, Pgeom(800, Pbrown(0.99, 1.01, 0.01, inf), inf)
).play;
)



