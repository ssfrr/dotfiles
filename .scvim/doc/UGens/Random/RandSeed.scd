RandSeed			set the synth's random generator seed

RandSeed.kr(trig, seed)
RandSeed.ar(trig, seed)

When the trigger signal changes from nonpositive to positve, the synth's random generator seed is reset to the given value. All synths that use the same random number generator reproduce the same sequence of numbers again. The seed may be a demand rate ugen.

see RandID ugen for setting the randgen id, 
also randomSeed for the client side equivalent

Note: An audio rate version is not available, because other ugens look up random seeds  at control rate only.



{ RandSeed.ar(Impulse.ar(3 ** MouseX.kr(1, 8)), 1871); WhiteNoise.ar * 0.1 }.play


{ RandSeed.ar(Impulse.ar(3 ** MouseX.kr(1, 8)), Dstutter(Dwhite().exprange(2, 400), Dwhite().range(0, 1000))); WhiteNoise.ar * 0.1 }.play


// start a noise patch

(
{
var noise, filterfreq;
noise = WhiteNoise.ar(0.05 ! 2) + Dust2.ar(70 ! 2);
filterfreq = LFNoise1.kr(3, 5500, 6000);
Resonz.ar(noise * 5, filterfreq, 0.5) + (noise * 0.5)  
}.play;
)

// reset the seed at a variable rate
(
x = { arg seed=1956;
		RandSeed.kr(Impulse.kr(MouseX.kr(0.1, 100)), seed);
}.play;
)	



x.set(\seed, 2001);
x.set(\seed, 1798);
x.set(\seed, 1902);


// above you can see that the sound of the LFNoise1 is not exactly reproduced (filter frequency)
// this is due to interference between the internal phase of the noise ugen and the 
// seed setting rate.

// a solution is to start a new synth:

(
SynthDef(\pseudorandom, { arg out, sustain=1, seed=1967, id=0;
	var noise, filterfreq;
	RandID.ir(id);
	RandSeed.ir(1, seed);
	
	
	noise = WhiteNoise.ar(0.05 ! 2) + Dust2.ar(70 ! 2);
	filterfreq = LFNoise1.kr(3, 5500, 6000);
	
	Out.ar(out,
		Resonz.ar(noise * 5, filterfreq, 0.5) + (noise * 0.5) 
		*
		Line.kr(1, 0, sustain, doneAction:2)
	)

}).send(s);
)

// the exact same sound is reproduced
(
fork {
	loop {
		Synth(\pseudorandom);
		1.1.wait; // wait a bit longer than sustain, so sounds don't overlap
	}
}
)

// changing the rand seed changes the sound:

(
fork {
	(1902..2005).do { |seed|
		seed.postln;
		3.do {
			Synth(\pseudorandom, [\seed, seed]);
			1.1.wait;
		}
	}
}
)

// cd skipper
(
fork {
	(1902..2005).do { |seed|
		seed.postln;
		rrand(4,10).do {
			Synth(\pseudorandom, [\seed, seed, \sustain, 0.05]);
			0.06.wait;
		}
	}
}
)

// if the sounds overlap, this does not work as expected anymore
// sounds vary.

(
fork {
	loop {
		Synth(\pseudorandom);
		0.8.wait; // instead of 1.1
	}
}
)

// rand id can be used to restrict the resetting of the seed to each voice:

(
fork {
	var id=0;
	(1902..2005).do { |seed|
		seed.postln;
		3.do {
			Synth(\pseudorandom, [\seed, seed, \id, id]);
			id = id + 1 % 16; // there is 16 different random generators
			0.8.wait;
		}
	}
}
)




