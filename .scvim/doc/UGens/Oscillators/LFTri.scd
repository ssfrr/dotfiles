LFTri				triangle oscillator

LFTri.ar(freq, iphase, mul, add)

A non-band-limited triangle oscillator. Output ranges from -1 to +1.
freq - frequency in Hertz
iphase - initial phase offset. For efficiency reasons this is a value ranging from 0 to 4.

// plot:
{ LFTri.ar(40) }.plot(0.1);
{ LFTri.ar(XLine.kr(1, 800, 0.1)) }.plot(0.1);

{ LFTri.ar(500, 0, 0.1) }.play

// used as both Oscillator and LFO:
{ LFTri.ar(LFTri.kr(4, 0, 200, 400), 0, 0.1) }.play

// phase. compare
{ LFTri.ar(LFTri.kr(0.1, iphase: 0) * 200 + 400, 0, 0.1) }.play
{ LFTri.ar(LFTri.kr(0.1, iphase: 1) * 200 + 400, 0, 0.1) }.play
{ LFTri.ar(LFTri.kr(0.1, iphase: 2) * 200 + 400, 0, 0.1) }.play
{ LFTri.ar(LFTri.kr(0.1, iphase: 3) * 200 + 400, 0, 0.1) }.play

// together
{ LFTri.ar(LFTri.kr(0.05, iphase: (0..3)) * 200 + 400, 0, 0.1).sum }.play


