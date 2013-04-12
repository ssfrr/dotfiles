Rand				uniform distribution single random float value ugen

Rand(lo, hi)

Generates a single random float value in uniform distribution from lo to hi.
It generates this when the SynthDef first starts playing, and remains fixed for the duration of the synth's existence.

See also: LinRand, ExpRand


(
SynthDef(\help_Rand, { | out = 0, minmax = 1 |
	Out.ar(out,
		FSinOsc.ar(
			LinRand(200.0, 10000.0, minmax), 
			0, Line.kr(0.2, 0, 0.01, doneAction:2))
	)
}).send(s);
)

(
Routine({
	loop({
		Synth.new(\help_Rand); 
		0.04.wait;
	})
}).play;
)


