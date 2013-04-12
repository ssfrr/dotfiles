MultiTap				multiple tap delay

MultiTap.ar(timesArray, levelsArray, in, mul, add, bufnum)

This is a wrapper  which creates a multiple tap delay line using RecordBuf and PlayBuf.
timesArray - a Ref to an Array of delay times in seconds.
levelsArray - a Ref to an Array of amplitudes.
in - the input signal.
bufnum - the number of the buffer to use for the delay. This must be at least as long as the longest tap time.

s.boot;
b = Buffer.alloc(s, s.sampleRate);
(
{
	MultiTap.ar(`[0.1, 0.2, 0.3, 0.4], `[0.1, 0.2, 0.4, 0.8], 
		Decay.ar(Dust.ar(2), 0.1, PinkNoise.ar), bufnum: b)
}.play
)



