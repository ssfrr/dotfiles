BufFrames			current number of frames allocated in the buffer

superclass: BufInfoUGenBase

returns the current number of allocated frames

	*kr(bufnum)
	*ir(bufnum)
		the .ir method is not the safest choice. Since a buffer can be reallocated at any time,
		using .ir will not track the changes.

	
// example

s.sendMsg("/b_allocRead", 0, "sounds/a11wlk01.wav");

// indexing with a phasor
{ BufRd.ar(1, 0, Phasor.ar(0, BufRateScale.kr(0), 0, BufFrames.kr(0))) }.play;


// indexing by hand
{ BufRd.ar(1, 0, K2A.ar(MouseX.kr(0, BufFrames.kr(0)))) }.play;


