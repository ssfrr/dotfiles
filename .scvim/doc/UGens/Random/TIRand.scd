TIRand			triggered integer random number generator

TIRand.kr(lo, hi, trig)
TIRand.ar(lo, hi, trig)

Generates a random integer value in uniform distribution from lo to hi 
each time the trig signal changes from nonpositive to positive values


(
SynthDef("help-TRand", { 
	var trig, outBus;
	trig = Dust.kr(10);
	outBus = TIRand.kr(0, 1, trig); //play on random channel between 0 and 1
	Out.ar(outBus, PinkNoise.ar(0.2))
	
}).play;
)

(
{ 
	var trig = Dust.kr(10);
	SinOsc.ar(
			TIRand.kr(4, 12, trig) * 100
		) * 0.1
}.play;
)

(
{ 
	var trig = Dust.ar(MouseX.kr(1, 8000, 1));
	SinOsc.ar(
			TIRand.ar(4, 12, trig) * 100
		) * 0.1
}.play;
)


