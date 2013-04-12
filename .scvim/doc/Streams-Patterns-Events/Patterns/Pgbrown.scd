Pgbrown			geometric brownian motion pattern

superclass: Pbrown

Pgbrown(lo, hi, step, length)

Returns a stream that behaves like a geometric brownian motion. 

lo, hi - lower and upper boundary of values  (default: 0.0 and 1.0)
step - maximum multiplication factor per step (omega) - the distribution is xrand2.  (default: 0.125)
length - number of values produced (default: inf)


See also: BrownNoise, Pbrown


// example

(
var a, b;
a = Pgbrown(0.0, 1.0, 0.2, inf);
b = a.asStream;
7.do({ b.next.postln; });
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
a = Pgbrown(1.0, 2.0, 0.1, inf).asStream;
Routine({
	loop({
	Synth(\help_sinegrain, [\freq, a.next * 600 + 300]);
	0.02.wait;
	})
}).play;
)

// compare with normal brownian motion:

(
var a;
a = Pbrown(1.0, 2.0, 0.1, inf).asStream;
Routine({
	loop({
	Synth(\help_sinegrain, [\freq, a.next * 600 + 300]);
	0.02.wait;
	})
}).play;
)








