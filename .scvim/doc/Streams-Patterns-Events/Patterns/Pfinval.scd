Pfinval 			limit number of items embedded in a stream


superclass: Pfin

Pfinval(count, pattern)

embeds count elements of the pattern into the stream

Note: Pfinval is not appropriate for wrapping Pmono, Pfx etc. For these types of event patterns, you should use Pfin


(
var a, b;
a = Pfinval(5, Pseq(#[1, 2, 3],inf));
b = a.asStream;
9.do({ b.next.postln; });
)


Pfinval used as a sequence of pitches


(
SynthDef(\help_sinegrain, 
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).add;
)

(
var c, b;
c = Pn(Pfinval({ rrand(3, 5)}, Pseq([1, 2, 3, 4, 5, 6],inf)*4+65),inf);
b = c.asStream;
Routine({
	loop({
			Synth(\help_sinegrain, [\freq, b.next.midicps]);
			0.12.wait;
	})
}).play;
)



