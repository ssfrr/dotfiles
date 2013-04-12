OneZero			one zero filter

Inherits from: Object : AbstractFunction : UGen : Filter : OnePole


OneZero.ar(in, coef, mul, add)
OneZero.kr(in, coef, mul, add)

A one zero filter. Implements the formula :

out(i) = ((1 - abs(coef)) * in(i)) + (coef * in(i-1))

in - input signal to be processed
coef - feed forward coefficient. +0.5 makes a two point averaging filter (see also LPZ1), 
-0.5 makes a differentiator (see also HPZ1),  +1 makes a single sample delay (see also Delay1), 
-1 makes an inverted single sample delay. 

{ OneZero.ar(WhiteNoise.ar(0.5), 0.5) }.play

{ OneZero.ar(WhiteNoise.ar(0.5), -0.5) }.play

{ OneZero.ar(WhiteNoise.ar(0.5), Line.kr(-0.5, 0.5, 10)) }.play



