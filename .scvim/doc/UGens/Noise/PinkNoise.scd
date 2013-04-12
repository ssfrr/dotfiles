PinkNoise		1/f noise	

PinkNoise.ar(mul, add)
PinkNoise.kr(mul, add)

see also: WhiteNoise, BrownNoise, Randomness

Generates noise whose spectrum falls off in power by 3 dB per octave.
This gives equal power over the span of each octave.
This version gives 8 octaves of pink noise.

// compare:
{ PinkNoise.ar(0.3) }.play;
{ WhiteNoise.ar(0.3) }.play;


// pink noise as a frequency modulator
{ SinOsc.ar(PinkNoise.ar(100, 200)) * 0.1 }.play;

// filtered pink noise
{ BPF.ar(PinkNoise.ar(0.1.dup), MouseX.kr(40, 17000, 1), 0.2) }.play;


