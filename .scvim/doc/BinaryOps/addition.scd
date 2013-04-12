+				addition

BinaryOperator

a + b

{ FSinOsc.ar(800, 0, 0.1) + PinkNoise.ar(0.1) }.play;

// DC offset; add: 0.1 would be more efficient
{ FSinOsc.ar + 0.1 }.play 




