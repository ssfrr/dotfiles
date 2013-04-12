Delay1		single sample delay

Delays the input by 1 sample.
Delay1.ar(in, mul, add)

in - input to be delayed.

Note: for audio-rate signals the delay is 1 audio frame, and for control-rate signals the delay is 1 control period.

(
plot {
	var z;
	z = Dust.ar(1000);
	[z, z - Delay1.ar(z)] 	// [ original, subtract delayed from original ]
}
)

(
scope {
	var z = LFNoise1.ar(290);
	[z, Delay1.ar(z) > z] // [original, 1 if rising, else 0]
}
)





