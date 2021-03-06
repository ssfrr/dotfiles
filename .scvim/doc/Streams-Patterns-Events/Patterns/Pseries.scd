Pseries			artithmetic series pattern

superclass: Pattern

Pseries(start, step, length)

Returns a stream that behaves like an arithmetric series. 

start - start value  (default: 0)
step - addition factor.  (default: 1)
length - number of values produced (default: inf)


See also: Pgeom


// example

(
var a;
a = Pgeom(1.0, 1.1, inf);
a.asStream.nextN(100).plot;
)


// sound example
(
SynthDef(\help_sinegrain, 
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).add;
)


(
var a;
a = Pseries(300, 20, 70).asStream;
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
	\freq, Pseries(800.0, Pbrown(-1.0, 3.0, 0.1, inf), inf)
).play;
)




