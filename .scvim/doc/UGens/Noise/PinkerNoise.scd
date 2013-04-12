PinkerNoise

PinkerNoise.ar(mul, add)

Generates noise whose spectrum falls off in power by 3 dB per octave.
This gives equal power over the span of each octave.
This version gives 16 octaves of pink noise, whereas PinkNoise only gives 8 octaves.

//not installed
(
SynthDef("help-PinkerNoise", { arg out=0;
	Out.ar(out, 
		PinkerNoise.ar(0.5)
	)
}).play;
)


