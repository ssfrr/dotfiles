BufRateScale			buffer rate scaling in respect to server samplerate

superclass: BufInfoUGenBase

returns a ratio by which the playback of a soundfile is to be scaled

	*kr(bufnum)
	*ir(bufnum)
		the .ir method is not the safest choice. Since a buffer can be reallocated at any time,
		using .ir will not track the changes.

	
// example

s.sendMsg("/b_allocRead", 0, "sounds/a11wlk01.wav");

(
x = { arg rate=1; 
	BufRd.ar(1, 0, Phasor.ar(0, BufRateScale.kr(0) * rate, 0, BufFrames.kr(0))) 
}.play;
)


