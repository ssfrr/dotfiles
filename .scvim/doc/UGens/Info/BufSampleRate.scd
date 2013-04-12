BufSampleRate			buffer sample rate

superclass: BufInfoUGenBase

returns the buffers current sample rate 

	*kr(bufnum)
	*ir(bufnum)
		the .ir method is not the safest choice. Since a buffer can be reallocated at any time,
		using .ir will not track the changes.

	
// example

s.sendMsg("/b_allocRead", 0, "sounds/a11wlk01.wav");

// compares a 1102.5 Hz sine tone (11025 * 0.1, left) with a 1100 Hz tone (right)
// the apollo sample has a sample rate of 11.025 kHz
(
{ 
	var freq;
	freq = [ BufSampleRate.kr(0) * 0.1, 1100];
	SinOsc.ar(freq, 0, 0.1) 
}.play; 
)


