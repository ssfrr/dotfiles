clip2			bilateral clipping

BinaryOperator

clip2(a, b)
a clip2: b
a.clip2(b)

clips input wave a to +/- b

Server.internal.boot;

{ FSinOsc.ar(400).clip2(0.2) }.scope; // clipping distortion

{ FSinOsc.ar(1000).clip2(Line.kr(0,1,8)) }.scope;



