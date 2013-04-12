BrownNoise				browninan motion	

BrownNoise.ar(mul, add)
BrownNoise.kr(mul, add)

Generates noise whose spectrum falls off in power by 6 dB per octave.

see also: WhiteNoise, PinkNoise, Randomness

// compare
{ BrownNoise.ar(0.5) }.play;
{ WhiteNoise.ar(0.5) }.play;

// brownian noise as a frequency modulator
{ SinOsc.ar(BrownNoise.ar(100, 200)) * 0.1 }.play;

// filtered brown noise
{ BPF.ar(BrownNoise.ar(0.1.dup), MouseX.kr(40, 17000, 1), 0.2) }.play;


