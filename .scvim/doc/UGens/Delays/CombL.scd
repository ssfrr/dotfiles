CombL	comb delay line with linear interpolation

CombL.ar(in, maxdelaytime, delaytime, decaytime, mul, add)
CombL.kr(in, maxdelaytime, delaytime, decaytime, mul, add)

Comb delay line with linear interpolation. See also CombN which uses no interpolation, and CombC which uses cubic interpolation. Cubic interpolation is more computationally expensive than linear, but more accurate.

See also BufCombL.

in - the input signal.
maxdelaytime - the maximum delay time in seconds. used to initialize the delay buffer size.
delaytime - delay time in seconds.
decaytime - time for the echoes to decay by 60 decibels. If this time is negative then the feedback
coefficient will be negative, thus emphasizing only odd harmonics at an octave lower.

// These examples compare the variants, so that you can hear the difference in interpolation

// Comb used as a resonator. The resonant fundamental is equal to 
// reciprocal of the delay time.
{ CombN.ar(WhiteNoise.ar(0.01), 0.01, XLine.kr(0.0001, 0.01, 20), 0.2) }.play;

{ CombL.ar(WhiteNoise.ar(0.01), 0.01, XLine.kr(0.0001, 0.01, 20), 0.2) }.play;

{ CombC.ar(WhiteNoise.ar(0.01), 0.01, XLine.kr(0.0001, 0.01, 20), 0.2) }.play;

// with negative feedback:
{ CombN.ar(WhiteNoise.ar(0.01), 0.01, XLine.kr(0.0001, 0.01, 20), -0.2) }.play;

{ CombL.ar(WhiteNoise.ar(0.01), 0.01, XLine.kr(0.0001, 0.01, 20), -0.2) }.play;

{ CombC.ar(WhiteNoise.ar(0.01), 0.01, XLine.kr(0.0001, 0.01, 20), -0.2) }.play;

// used as an echo. 
{ CombL.ar(Decay.ar(Dust.ar(1,0.5), 0.2, WhiteNoise.ar), 0.2, 0.2, 3) }.play;


