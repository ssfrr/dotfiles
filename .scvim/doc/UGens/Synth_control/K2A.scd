K2A		control rate to audio rate converter


K2A.ar(in)



To be able to play a control rate UGen into an audio rate UGen, sometimes the rate must be converted.
K2A converts via linear interpolation.

in - input signal



{ K2A.ar(WhiteNoise.kr(0.3)) }.scope;


// compare:

(
{ 
	[
		K2A.ar(WhiteNoise.kr(0.3)),
		WhiteNoise.ar(0.3)
	]
}.scope;
)


(
{ 
	var freq, blockSize, sampleRate;
	blockSize = Server.internal.options.blockSize; // usually 64
	sampleRate = Server.internal.sampleRate;
	freq = MouseX.kr(0.1, 40, 1) / blockSize * sampleRate;
	[
		K2A.ar(LFNoise0.kr(freq)),
		LFNoise0.ar(freq)
	] * 0.3
}.scope;
)






