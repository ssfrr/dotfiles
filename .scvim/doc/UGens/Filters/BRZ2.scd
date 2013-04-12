BRZ2					two zero fixed midcut

Inherits from: Object : AbstractFunction : UGen : Filter : LPZ2

BRZ2.ar(in, mul, add)
BRZ2.kr(in, mul, add)


A special case fixed filter. Implements the formula:

out(i) = 0.5 * (in(i) + in(i-2))

This filter cuts out frequencies around 1/2 of the Nyquist frequency.

// Compare:

{ WhiteNoise.ar(0.25) }.play;

{ BRZ2.ar(WhiteNoise.ar(0.25)) }.play;



