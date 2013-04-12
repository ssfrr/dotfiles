Pfuncn			function pattern of given length

superclass: Pattern

Pfunc(func, repeats)

Returns a stream that returns values from the func.

func - stream function
repeats -  end after this number of times

See also: Pfunc


// example

(
var a, b, c;
a = Pfuncn({ exprand(0.1, 2.0) + #[1, 2, 3, 6].choose }, 2);
b = Pfuncn({ #[-2, -3].choose }, 2);
Pseq([a, b], inf).asStream.nextN(20).postln;
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
var a, b, c;
a = Pfuncn({ exprand(0.1, 2.0) + #[1, 2, 3, 6].choose }, 2);
b = Pfuncn({ #[-2, -3].choose }, 7);
c = Pseq([a, b], inf).asStream;
{
	c.do { |val|
		Synth(\help_sinegrain, [\freq, val * 100 + 300]);
		0.02.wait;
	}
}.fork;
)




