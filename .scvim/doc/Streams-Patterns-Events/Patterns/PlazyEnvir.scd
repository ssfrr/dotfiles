PlazyEnvir			instantiate new patterns from a function

superclass: Plazy


Evaluates a function that returns a pattern and embeds it in a stream.
In difference to Plazy, the function is evaluated using the environment passed in by the stream


PlazyEnvir(func)

func: A function that returns a pattern or any other valid pattern input

 
(
a = PlazyEnvir({ arg a=0, b=1; Pshuf([a, a, b], 2) }); // a, b default to 0,1
x = Pn(a, inf).asStream;

10.do { x.next.postln }; Post.nl;
e = (a:100);
10.do { x.next(e).postln }; Post.nl;
e = (a:100, b:200);
10.do { x.next(e).postln };
)


PlazyEnvir used to produce a Pbind:
 
(
SynthDef(\help_sinegrain, 
	{ arg out=0, freq=440, sustain=0.05, pan=0;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, Pan2.ar(SinOsc.ar(freq, 0, env), pan))
	}).add;

a = PlazyEnvir({ arg g=0, h=0, dur=1;
	postf("g: %, h: %, dur: %\n", g, h, dur);
	Pbind(
		\instrument, \help_sinegrain,
		\dur, dur,
		\degree, Pseq([g, g, h, g, h], 2)
	)
});

)


// different variants
(a <> (g: 0, h: 3, dur:0.2)).play; // single stream
(a <> (g: [0, 4], h: [3, -1], dur:0.2)).play; // same durations, two streams

// for more about the composition operator <> see: Pchain


Some parameters, like duration, cannot be used in the form of an array in the Pbind. 
For full parallel expansion see PlazyEnvirN







