SinOsc			interpolating sine wavetable oscillator

SinOsc.ar(freq, phase, mul, add)

Sinusoidal oscillator; a sine tone.    

Note: This is the same as Osc except that the table has already been fixed as a sine table of 8192 entries.

freq - frequency in Hertz
phase - phase offset or modulator in radians


{ SinOsc.ar(200, 0, 0.5) }.play;


// modulate freq
{ SinOsc.ar(XLine.kr(2000, 200), 0, 0.5) }.play;

// modulate freq
{ SinOsc.ar(SinOsc.ar(XLine.kr(1, 1000, 9), 0, 200, 800), 0, 0.25) }.play; 


// modulate phase
{ SinOsc.ar(800, SinOsc.ar(XLine.kr(1, 1000, 9), 0, 2pi), 0.25) }.play; 



