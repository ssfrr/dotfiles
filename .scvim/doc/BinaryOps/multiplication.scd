*				multiplication

BinaryOperator

a * b


// Same as mul: 0.5
{ SinOsc.ar(440) * 0.5 }.play;

// This creates a beating effect (subaudio rate).
{ FSinOsc.kr(10) * PinkNoise.ar(0.5) }.play; 

// This is ring modulation.
{ SinOsc.ar(XLine.kr(100, 1001, 10), 0, 0.5) * SyncSaw.ar(100, 200, 0.5) }.play; 



