GrayNoise

GrayNoise.ar(mul, add)

Generates noise which results from flipping random bits in a word.
This type of noise has a high RMS level relative to its peak to peak level.
The spectrum is emphasized towards lower frequencies.


(
SynthDef("help-GrayNoise", { arg out=0;
	Out.ar(out, 
		GrayNoise.ar(0.1)
	)
}).play;
)


