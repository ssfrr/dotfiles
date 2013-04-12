LFClipNoise				clipped noise

LFClipNoise.ar(freq, mul, add)

Randomly generates the values -1 or +1 at a rate given by the nearest integer division
of the sample rate by the freq argument. It is probably pretty hard on your speakers!
freq - approximate rate at which to generate random values.


(
SynthDef("help-LFClipNoise", { arg out=0;
	Out.ar(out, 
		LFClipNoise.ar(1000, 0.25)
	)
}).play;
)

//modulate frequency
(
SynthDef("help-LFClipNoise", { arg out=0;
	Out.ar(out, 
		LFClipNoise.ar(XLine.kr(1000, 10000, 10), 0.25)
	)
}).play;
)

//use as frequency control
(
SynthDef("help-LFClipNoise", { arg out=0;
	Out.ar(out, 
		SinOsc.ar(
			LFClipNoise.ar(4, 200, 600),
			0, 0.2
		)
	)
}).play;
)


