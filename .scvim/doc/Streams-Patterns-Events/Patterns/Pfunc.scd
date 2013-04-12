Pfunc			function pattern

superclass: Pattern

Pfunc(nextFunc, resetFunc)

Returns a stream that returns values from the nextFunc.

nextFunc - stream function
resetFunc -  function that is called when the stream is reset.

See also: Pfuncn


// example

(
var a, x;
a = Pfunc({ exprand(0.1, 2.0) + #[1, 2, 3, 6].choose }, { \reset.postln });
x = a.asStream;
x.nextN(20).postln;
x.reset;
)


// sound example
(
SynthDef(\help_sinegrain, 
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).add;
)


(
var a;
a = Pfunc({ exprand(0.1, 0.3) + #[1, 2, 3, 6, 7].choose }).asStream;
{
	a.do { |val|
		Synth(\help_sinegrain, [\freq, val * 100 + 300]);
		0.02.wait;
	}
}.fork;
)




