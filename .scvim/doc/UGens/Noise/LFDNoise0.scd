LFDNoise0					dynamic step noise

LFDNoise0.ar(freq, mul, add)
LFDNoise0.kr(freq, mul, add)

Like LFNoise0, it generates random values at a rate given 
by the freq argument,  with two differences:

-no time quantization 
-fast recovery from low freq values.

(LFNoise0,1,2 quantize to the nearest integer division of the samplerate,
and they poll the freq argument only when scheduled, and thus seem 
to hang when freqs get very low).

If you don't need very high or very low freqs, or use fixed freqs, 
LFNoise0 is more efficient.

freq - rate at which to generate random values.

see also: LFNoise0, LFDNoise1, LFDNoise3


// try wiggling mouse quickly;
// LFNoise frequently seems stuck, LFDNoise changes smoothly.

{ LFNoise0.ar(MouseX.kr(0.1, 1000, 1), 0.1)  }.play

{ LFDNoise0.ar(MouseX.kr(0.1, 1000, 1), 0.1)  }.play

// silent for 2 secs before going up in freq

{ LFNoise0.ar(XLine.kr(0.5, 10000, 3), 0.1) }.scope;

{ LFDNoise0.ar(XLine.kr(0.5, 10000, 3), 0.1) }.scope;


// LFNoise quantizes time steps at high freqs, LFDNoise does not:

{ LFNoise0.ar(XLine.kr(1000, 20000, 10), 0.1) }.scope;

{ LFDNoise0.ar(XLine.kr(1000, 20000, 10), 0.1) }.scope;

{ LFNoise2.ar(1000, 0.25) }.play;





