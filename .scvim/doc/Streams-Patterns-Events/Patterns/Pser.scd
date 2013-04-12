Pser 			sequentially embed values in a list

superclass: ListPattern

is like Pseq, however the repeats variable gives the number of items returned 
instead of the number of complete cycles.

(
var a, b;
a = Pser([1, 2, 3], 5);	// return 5 items
b = a.asStream;
6.do({ b.next.postln; });
)

Pser used as a sequence of pitches:


(
SynthDef(\help_sinegrain, 
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).add;
)


(
a = Pser([Pser(#[60, 61, 63, 65, 72], 3)], inf).asStream;
Routine({
	loop({
	Synth(\help_sinegrain, [\freq, a.next.midicps]);
	0.2.wait;
	})
}).play;
)





