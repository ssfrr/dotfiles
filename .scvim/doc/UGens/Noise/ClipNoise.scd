ClipNoise

ClipNoise.ar(mul, add)

Generates noise whose values are either -1 or 1. 
This produces the maximum energy for the least peak to peak amplitude.

(
SynthDef("help-ClipNoise", { arg out=0;
	Out.ar(out, 
		ClipNoise.ar(0.2)
	)
}).play;
)



