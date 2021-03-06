Pshuf				sequentially embed values in a list in constant, but random order

superclass: ListPatterns

returns a shuffled version of the list item by item, with n repeats.

Pshuf(list, repeats)

(
var a, b;
a = Pshuf([1, 2, 3, 4, 5], 3);	// repeat 3 times
b = a.asStream;
16.do({ b.next.postln; });
)

Pshuf used as a sequence of pitches:

(
SynthDef(\help_sinegrain, 
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).add;
)


(
a = Pn(Pshuf(#[60, 60, 60, 61, 63, 65, 72], 4), inf).asStream;
Routine({
	loop({
	Synth(\help_sinegrain, [\freq, a.next.midicps]);
	0.15.wait;
	})
}).play;
)



