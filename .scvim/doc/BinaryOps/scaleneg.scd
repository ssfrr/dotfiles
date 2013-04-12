scaleneg		scale negative part of input wave

BinaryOperator

scaleneg(a, b)
a scaleneg: b
a.scaleneg(b)

a*b when a < 0, otherwise a.

{ FSinOsc.ar(500).scaleneg(Line.ar(1,-1,4)) }.play;



