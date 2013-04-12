WhiteNoise			equal power noise

WhiteNoise.ar(mul, add)
WhiteNoise.kr(mul, add)

Generates noise whose spectrum has equal power at all frequencies.

see also: PinkNoise, BrownNoise, Randomness


// compare
{ WhiteNoise.ar(0.5) }.play;
{ PinkNoise.ar(0.5) }.play;

// white noise as a frequency modulator
{ SinOsc.ar(WhiteNoise.ar(100, 200)) * 0.1 }.play;

// filtered white noise
{ BPF.ar(WhiteNoise.ar(0.1.dup), MouseX.kr(40, 17000, 1), 0.2) }.play;


