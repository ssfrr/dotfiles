LFDNoise1				dynamic ramp noise

LFDNoise1.ar(freq, mul, add)
LFDNoise1.kr(freq, mul, add)


Like LFNoise1, it generates linearly interpolated random values 
at a rate given by the freq argument, with two differences:

-no time quantization 
-fast recovery from low freq values.

(LFNoise0,1,2 quantize to the nearest integer division of the samplerate,
and they poll the freq argument only when scheduled, and thus seem 
to hang when freqs get very low).

If you don't need very high or very low freqs, or use fixed freqs, 
LFNoise1 is more efficient.

freq - rate at which to generate random values.


see also: LFDNoise0, LFNoise1, LFDNoise3




// try wiggling mouse quickly;
// LFNoise frequently seems stuck, LFDNoise changes smoothly.
 
{  SinOsc.ar(LFNoise1.ar(MouseX.kr(0.1, 1000, 1), 200, 500), 0, 0.2)  }.play

{  SinOsc.ar(LFDNoise1.ar(MouseX.kr(0.1, 1000, 1), 200, 500), 0, 0.2)  }.play


// LFNoise quantizes time steps at high freqs, LFDNoise does not:

{ LFNoise1.ar(XLine.kr(2000, 20000, 8), 0.1) }.scope;

{ LFDNoise1.ar(XLine.kr(2000, 20000, 8), 0.1) }.scope;





