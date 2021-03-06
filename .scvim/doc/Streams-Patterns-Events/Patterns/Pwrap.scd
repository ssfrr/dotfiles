Pwrap				constrain the range of output values by wrapping

superclass: FilterPattern

Pwrap(pattern, lo, hi)

Note: this is equivalent to pattern.wrap(lo, hi)

see also SimpleNumber


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
	Pwrap(
		Pgeom(200,1.07,96),
		200,
		1000.0
	),
	inf
);
x = a.asStream;

Routine({
	loop({
			Synth(\help_sinegrain, [\freq, x.next.debug,\dur,0.3]);
			0.12.wait;
	})
}).play;
)

- felix


