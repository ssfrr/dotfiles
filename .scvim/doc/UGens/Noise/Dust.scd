Dust						random impulses

Dust.ar(density, mul, add)

Generates random impulses from 0 to +1.
density - average number of impulses per second



(
SynthDef("help-Dust", { arg out=0;
	Out.ar(out, 
		Dust.ar(200, 0.5)
	)
}).play;
)

(
SynthDef("help-Dust", { arg out=0;
	Out.ar(out, 
		Dust.ar(XLine.kr(20000, 2, 10), 0.5)
	)
}).play;
)




