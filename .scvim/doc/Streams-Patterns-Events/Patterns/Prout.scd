Prout			routine pattern

superclass: Pattern

Prout(func)

Returns a routine from the function.

func - routine function


See also: Proutine, Routine

note that there is a shortcut to create a Prout:

p(func)


// example

(
var a;
a = Prout({ loop { 1.yield; 2.yield; 7.yield; 10.do { 1.0.rand.yield } }});
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
a = Prout({ loop { 1.yield; 2.yield; 7.yield; 10.do { 1.0.rand.yield } }}).asStream;
{
	a.do { |val|
		Synth(\help_sinegrain, [\freq, val * 100 + 300]);
		0.02.wait;
	}
}.fork;
)

// shortcut:

(
Pbind(
	\instrument, \help_sinegrain, 
	\freq, p { loop { ([1000, 2000].choose + [100, 200].choose + [10, 20].choose).postln.yield } },
	\dur, 0.1
).play;
)






