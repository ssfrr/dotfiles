PlazyEnvirN			instantiate new patterns from a function

superclass: PlazyEnvir


Evaluates a function that returns a pattern and embeds it in a stream.
In difference to Plazy, the function is evaluated using the environment passed in by the stream.
In difference to PlazyEnvir, PlayzEnvirN expands to multiple parallel patterns if the function arguments
receive multiple channels. In difference to PlazyEnvir, this works only with event streams.


PlazyEnvirN(func)

func: A function that returns a pattern or any other valid pattern input


 
// example

(
SynthDef(\help_sinegrain, 
	{ arg out=0, freq=440, sustain=0.05, pan=0;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, Pan2.ar(SinOsc.ar(freq, 0, env), pan))
	}).add;

a = PlazyEnvirN({ arg g=0, h=0, dur=1;
	postf("g: %, h: %, dur: %\n", g, h, dur);

	Pbind(
		\instrument, \help_sinegrain,
		\dur, dur,
		\degree, Pseq([g, g, h, g, h], 2)
	)
});
);


// different variants
(a <> (g: 0, h: 3, dur:0.2)).play; // single stream
(a <> (g: [0, 4], h: [3, -1], dur:0.2)).play; // same durations, two streams
(a <> (g: [0, 4], h: [3, -1], dur: [0.2, 0.3])).play; // different durations, two streams

// for more about the composition operator <> see: Pchain


