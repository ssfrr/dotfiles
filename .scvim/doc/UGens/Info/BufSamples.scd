BufSamples			current number of samples allocated in the buffer

superclass: BufInfoUGenBase

Returns the current number of allocated samples. A sample is not the same as a frame (compare with BufFrames); a frame includes the samples in each channel of the buffer. Only for a mono buffer are samples the same as frames. 
samples = frames * numChannels

	*kr(bufnum)
	*ir(bufnum)
		the .ir method is not the safest choice. Since a buffer can be reallocated at any time,
		using .ir will not track the changes.

	
// example; this buffer is mono, so the number of samples matches the number of frames
s.sendMsg("/b_allocRead", 0, "sounds/a11wlk01.wav");


// indexing with a phasor
{ BufRd.ar(1, 0, Phasor.ar(0, BufRateScale.kr(0), 0, BufSamples.kr(0))) }.play;


// indexing by hand
{ BufRd.ar(1, 0, K2A.ar(MouseX.kr(0, BufSamples.kr(0)))) }.play;


