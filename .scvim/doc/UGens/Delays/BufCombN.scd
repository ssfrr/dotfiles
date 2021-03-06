BufCombN buffer based comb delay line with no interpolation

BufCombN.ar(buf, in, delaytime, decaytime, mul, add)
BufCombN.kr(buf, in, delaytime, decaytime, mul, add)

Comb delay line with no interpolation which uses a buffer for its internal memory. See also [BufCombL] which uses linear interpolation, and BufCombC which uses cubic interpolation. Cubic interpolation is more computationally expensive than linear, but more accurate.

See also CombN.

buf - buffer number.
in - the input signal.
delaytime - delay time in seconds.
decaytime - time for the echoes to decay by 60 decibels. If this time is negative then the feedback
coefficient will be negative, thus emphasizing only odd harmonics at an octave lower.
Warning: For reasons of efficiency, the effective 
buffer size is limited to the previous power of two. So, if 44100 
samples are allocated, the maximum delay would be 32768 samples.

// These examples compare the variants, so that you can hear the difference in interpolation

// allocate buffer
b = Buffer.alloc(s,44100,1);

// Comb used as a resonator. The resonant fundamental is equal to 
// reciprocal of the delay time.
{ BufCombN.ar(b, WhiteNoise.ar(0.01), XLine.kr(0.0001, 0.01, 20), 0.2) }.play;

{ BufCombL.ar(b, WhiteNoise.ar(0.01), XLine.kr(0.0001, 0.01, 20), 0.2) }.play;

{ BufCombC.ar(b, WhiteNoise.ar(0.01), XLine.kr(0.0001, 0.01, 20), 0.2) }.play;

// with negative feedback:
{ BufCombN.ar(b, WhiteNoise.ar(0.01), XLine.kr(0.0001, 0.01, 20), -0.2) }.play;

{ BufCombL.ar(b, WhiteNoise.ar(0.01), XLine.kr(0.0001, 0.01, 20), -0.2) }.play;

{ BufCombC.ar(b, WhiteNoise.ar(0.01), XLine.kr(0.0001, 0.01, 20), -0.2) }.play;

// used as an echo. 
{ BufCombN.ar(b, Decay.ar(Dust.ar(1,0.5), 0.2, WhiteNoise.ar), 0.2, 3) }.play;


