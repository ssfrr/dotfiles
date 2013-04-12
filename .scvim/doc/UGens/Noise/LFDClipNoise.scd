LFDClipNoise				dynamic clipped noise

LFClipNoise.ar(freq, mul, add)

Like LFClipNoise, it generates the values -1 or +1 at a rate given 
by the freq argument,  with two differences: 

-no time quantization 
-fast recovery from low freq values.

(LFClipNoise, as well as LFNoise0,1,2 quantize to the nearest integer division 
of the samplerate, and they poll the freq argument only when scheduled;
thus they often seem to hang when freqs get very low).

If you don't need very high or very low freqs, or use fixed freqs, 
LFNoise0 is more efficient.

freq - rate at which to generate random values.


// try wiggling the mouse quickly;
// LFNoise frequently seems stuck, LFDNoise changes smoothly.

{ LFClipNoise.ar(MouseX.kr(0.1, 1000, 1), 0.1)  }.play

{ LFDClipNoise.ar(MouseX.kr(0.1, 1000, 1), 0.1)  }.play

// silent for 2 secs before going up in freq

{ LFClipNoise.ar(XLine.kr(0.5, 10000, 3), 0.1) }.scope;

{ LFDClipNoise.ar(XLine.kr(0.5, 10000, 3), 0.1) }.scope;


// LFNoise quantizes time steps at high freqs, LFDNoise does not:

{ LFClipNoise.ar(XLine.kr(1000, 20000, 10), 0.1) }.scope;

{ LFDClipNoise.ar(XLine.kr(1000, 20000, 10), 0.1) }.scope;



