RandID			set the synth's random generator id

RandID.kr(seed)
RandID.ir(seed)

Choose which random number generator to use for this synth. All synths that use the same generator reproduce the same sequence of numbers when the same seed is set again 

See also: RandSeed randomSeed



// start a noise patch and set the id of the generator
(
SynthDef(\help_RandID, { arg out=0, id=1;
	RandID.ir(id);
	Out.ar(out, 
		WhiteNoise.ar(0.05) + Dust2.ar(70) 
	)
}).send(s);
)

// reset the seed of my rgen at a variable rate
(
SynthDef(\help_RandSeed , { arg seed=1910, id=1;
		RandID.kr(id);
		RandSeed.kr(Impulse.kr(FSinOsc.kr(0.2, 0, 10, 11)), seed);
}).send(s);
	
)

// start two noise synths on left and right channel with a different randgen id
a = Synth(\help_RandID, [\out, 0, \id, 1]);
b = Synth(\help_RandID, [\out, 1, \id, 2]);

// reset the seed of randgen 1 
x = Synth(\help_RandSeed , [\id, 1]);

// change the target randgen to 2 (affects right channel)
x.set(\id, 2);





