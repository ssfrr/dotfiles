IRand

IRand(lo, hi)

Generates a single random integer value in uniform distribution from lo to hi


(
SynthDef("help-IRand", { 
	Out.ar(
		IRand(0, 1), //play on random channel between 0 and 1 
		FSinOsc.ar(500, 
			0, Line.kr(0.2, 0, 0.1, doneAction:2))
	)
}).send(s);
)

(
Routine({
	16.do({
		Synth.new("help-IRand"); 0.5.wait;
	})
}).play;
)


