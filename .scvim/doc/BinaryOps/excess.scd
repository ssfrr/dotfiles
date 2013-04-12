excess			clipping residual

BinaryOperator

excess(a, b)
a excess: b
a.excess(b)

Returns the difference of the original signal and its clipped form: (a - clip2(a,b)).

{ FSinOsc.ar(1000).excess(Line.kr(0,1,8)) }.play;



