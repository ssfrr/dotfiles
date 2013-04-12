TExpRand					triggered exponential random number generator

TExpRand.ar(lo, hi, trig)
TExpRand.kr(lo, hi, trig)

Generates a random float value in exponential distribution from lo to hi 
each time the trig signal changes from nonpositive to positive values
lo and hi must both have the same sign and be non-zero.



(
{ 
	var trig = Dust.kr(10);
	SinOsc.ar(
			TExpRand.kr(300.0, 3000.0, trig) 
		) * 0.1
}.play;
)

(
{ 
	var trig = Dust.ar(MouseX.kr(1, 8000, 1));
	SinOsc.ar(
			TExpRand.ar(300.0, 3000.0, trig)
		) * 0.1
}.play;
)


