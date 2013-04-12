LFSaw			sawtooth oscillator

LFSaw.ar(freq, iphase, mul, add)


A non-band-limited sawtooth oscillator. Output ranges from -1 to +1.

freq - frequency in Hertz
iphase - initial phase offset. For efficiency reasons this is a value ranging from 0 to 2.



{ LFSaw.ar(500, 1, 0.1) }.play

// used as both Oscillator and LFO:
{ LFSaw.ar(LFSaw.kr(4, 0, 200, 400), 0, 0.1) }.play



