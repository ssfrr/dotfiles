PdurStutter				partition a value into n equal subdivisions

PdurStutter(stutterPattern, floatPattern)

A filter pattern designed for a stream of float durations.

subdivides each duration by each stutter and yields that value stutter times.
a stutter of 0 will skip the duration value, a stutter of 1 yields the duration value
unaffected.

(
a = PdurStutter(
	Pseq(#[1,1,1,1,1,2,2,2,2,2,0,1,3,4,0],inf),
	Pseq(#[0.5, 1, 2, 0.25,0.25],inf)
);
x = a.asStream;
100.do({ x.next.postln; });
)



(
SynthDef(\help_sinegrain, 
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).add;
)
(

a = PdurStutter(
	Pseq(#[1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,4,4,4,4],inf),
	Pseq(#[0.5, 1, 2, 0.25,0.25],inf)
);
x = a.asStream;

Routine({
	loop({
			Synth.grain(\help_sinegrain, [\freq, 440]);
			x.next.wait;
	})
}).play(TempoClock.default);
)


(

a = PdurStutter(
	Pseq(#[1,1,1,1,1,2,2,2,2,2,3,3,3,3,4,4,0,4,4],inf),
	Pseq(#[0.5, 1, 2, 0.25,0.25],inf)
);
x = a.asStream;
Routine({
	loop({
			Synth.grain(\help_sinegrain, [\freq, 440]);
			x.next.wait;
	})
}).play(TempoClock.default);
)


Frequencies like being divided too.

(
a = PdurStutter(
	Pseq(#[1,1,1,1,1,2,2,2,2,2,3,3,3,3,4,4,0,4,4],inf),
	Pseq((80 + [ 0, 2, 3, 5, 7, 9, 10 ]).midicps ,inf)
);
x = a.asStream;
Routine({
	loop({
			Synth.grain(\help_sinegrain, [\freq, x.next.postln]);
			0.25.wait
	})
}).play(TempoClock.default);
)




-felix


