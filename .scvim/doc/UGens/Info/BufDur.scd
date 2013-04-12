BufDur			current duration of soundfile in buffer

superclass: BufInfoUGenBase

returns the current duration of soundfile

	*kr(bufnum)
	*ir(bufnum)
		the .ir method is not the safest choice. Since a buffer can be reallocated at any time,
		using .ir will not track the changes.

	
// example

s.sendMsg("/b_allocRead", 0, "sounds/a11wlk01.wav");


{ BufRd.ar(1, 0,  Sweep.ar(Impulse.ar(BufDur.kr(0).reciprocal), BufSampleRate.kr(0))) }.play;



