ExpRand				exponential distribution single random float value ugen

ExpRand(lo, hi)

Generates a single random float value in an exponential distributions from lo to hi.

See also: LinRand, Rand

(
SynthDef(\help_ExpRand, { | out = 0, n = 0 |
	Out.ar(out, 
		FSinOsc.ar(
			ExpRand(100.0, 8000.0, n), 
			0, Line.kr(0.2, 0, 0.01, doneAction:2))
	)
}).send(s);
)

(
Routine({
	inf.do({ arg i;
		Synth.new(\help_ExpRand); 
		0.05.wait;
	})
}).play;
)


