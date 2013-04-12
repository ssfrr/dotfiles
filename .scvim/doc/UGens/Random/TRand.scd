TRand			triggered random number generator

TRand.kr(lo, hi, trig)
TRand.ar(lo, hi, trig)

Generates a random float value in uniform distribution from lo to hi 
each time the trig signal changes from nonpositive to positive values


(
{ 
	var trig = Dust.kr(10);
	SinOsc.ar(
			TRand.kr(300, 3000, trig)
		) * 0.1
}.play;
)

(
{ 
	var trig = Dust.ar(MouseX.kr(1, 8000, 1));
	SinOsc.ar(
			TRand.ar(300, 3000, trig)
		) * 0.1
}.play;
)


