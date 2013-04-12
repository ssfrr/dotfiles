NRand

NRand(lo, hi, n)

Generates a single random float value in a sum of n uniform distributions from lo to hi.
	
n = 1 : uniform distribution - same as Rand
n = 2 : triangular distribution
n = 3 : smooth hump
as n increases, distribution converges towards gaussian

(
SynthDef("help-NRand", { arg out=0, n=0;
	Out.ar(out, 
		FSinOsc.ar(
			NRand(1200.0, 4000.0, n), 
			0, Line.kr(0.2, 0, 0.01, doneAction:2))
	)
}).send(s);
)

(
n = 0;
Routine({
	inf.do({ arg i;
		Synth.new("help-NRand", [\n, n]); 0.05.wait;
	})
}).play;
)

n = 1;
n = 2;
n = 4;


