Resonz			resonant filter

Inherits from: Object : AbstractFunction : UGen : Filter 

Resonz.ar(in, freq, rq, mul, add)
Resonz.kr(in, freq, rq, mul, add)

A two pole resonant filter with zeroes at z = +/- 1. Based on K. Steiglitz,  "A Note on Constant-Gain 
Digital Resonators," Computer Music Journal, vol 18, no. 4, pp. 8-10, Winter 1994.

in - input signal to be processed
freq - resonant frequency in Hertz
rq - bandwidth ratio (reciprocal of Q). rq = bandwidth / centerFreq
The reciprocal of Q is used rather than Q because it saves a divide operation inside the unit generator.

{ Resonz.ar(WhiteNoise.ar(0.5), 2000, 0.1) }.play

// modulate frequency
{ Resonz.ar(WhiteNoise.ar(0.5), XLine.kr(1000,8000,10), 0.05) }.play

// modulate bandwidth
{ Resonz.ar(WhiteNoise.ar(0.5), 2000, XLine.kr(1, 0.001, 8)) }.play

// modulate bandwidth opposite direction
{ Resonz.ar(WhiteNoise.ar(0.5), 2000, XLine.kr(0.001, 1, 8)) }.play



