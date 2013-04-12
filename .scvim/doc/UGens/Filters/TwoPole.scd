TwoPole			two pole filter

Inherits from: Object : AbstractFunction : UGen : Filter 

TwoPole.ar(in, freq, radius, mul, add)

A two pole filter. This provides lower level access to setting of pole location. 
For general purposes Resonz is better.

in - input signal to be processed
freq - frequency of pole angle.
radius - radius of pole. Should be between 0 and +1



// examples

{ TwoPole.ar(WhiteNoise.ar(0.005), 2000, 0.95) }.play

{ TwoPole.ar(WhiteNoise.ar(0.005), XLine.kr(800,8000,8), 0.95) }.play

{ TwoPole.ar(WhiteNoise.ar(0.005), MouseX.kr(800,8000,1), 0.95) }.play


