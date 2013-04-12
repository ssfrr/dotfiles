Crackle				chaotic noise function

Crackle.ar(param, mul, add)
Crackle.kr(param, mul, add)


A noise generator based on a chaotic function.
param - a parameter of the chaotic function with useful values from
just below 1.0 to just above 2.0. Towards 2.0 the sound crackles.



{ Crackle.ar(1.95, 0.5) }.play;


// modulate chaos parameter
{ Crackle.ar(Line.kr(1.0, 2.0, 3), 0.5, 0.5) }.play;


