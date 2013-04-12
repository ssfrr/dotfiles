LFDNoise3				dynamic cubic noise

LFDNoise3.ar(freq, mul, add)
LFDNoise3.kr(freq, mul, add)


Similar to LFNoise2, it generates polynomially interpolated random values 
at a rate given by the freq argument, with 3 differences:

-no time quantization 
-fast recovery from low freq values
-cubic instead of quadratic interpolation

(LFNoise0,1,2 quantize to the nearest integer division of the samplerate,
and they poll the freq argument only when scheduled, and thus seem 
to hang when freqs get very low).
If you don't need very high or very low freqs, or use fixed freqs, 
LFNoise2 is more efficient.

freq - rate at which to generate random values.

see also: LFDNoise0, LFDNoise1, LFNoise2



// try wiggling mouse quickly: 
// LFNoise2 overshoots when going from high to low freqs, LFDNoise changes smoothly.

{  SinOsc.ar(LFNoise2.ar(MouseX.kr(0.1, 1000, 1), 200, 500), 0, 0.2)  }.play

{  SinOsc.ar(LFDNoise3.ar(MouseX.kr(0.1, 1000, 1), 200, 500), 0, 0.2)  }.play


// LFNoise quantizes time steps at high freqs, LFDNoise does not:

{ LFNoise2.ar(XLine.kr(2000, 20000, 8), 0.1) }.scope;

{ LFDNoise3.ar(XLine.kr(2000, 20000, 8), 0.1) }.scope;

// use as frequency control
(
{
		SinOsc.ar(
			LFDNoise3.ar(4, 400, 450),
			0, 0.2
		)
}.play;
)





