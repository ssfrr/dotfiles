Ppatmod			modify a given pattern before passing it into the stream

superclass: Pattern


Ppatmod(pattern, func, repeats)

func - A function that modifies the enclosed pattern and embeds it in the stream.

see also Plazy
 
 
(
a = Ppatmod(
	Pseq([0, 0, 0, 0],1),
	{ arg pat, i;
		var list;
		list = pat.list;
		pat.list = list.put(list.size.rand, 2);
	}, inf);

x = a.asStream;
30.do({ x.next.postln });
)


Ppatmod used to modify a pattern that produces a sequence of pitches:
 
(
SynthDef(\help_sinegrain, 
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).add;
)


(
a = Pn(
		Ppatmod(
			Pseq([0, 0, 0, 0],1),
			{ arg pat, i;
				var list;
				list = pat.list;
				pat.list = list.put(list.size.rand, 2);
			}, 15),
	inf).asStream;

Routine({
	loop({
		Synth(\help_sinegrain, [\freq, (a.next*5+77).midicps]);
	0.13.wait;
	})
}).play;
)





