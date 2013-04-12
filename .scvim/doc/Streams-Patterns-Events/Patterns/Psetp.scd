Psetp					event pattern that sets values of one key

superclass: Pset

Psetp(name, value, pattern)

sets a value in an event stream until it ends, repeats this with new values until
the value stream ends.

value can be a pattern, a stream or an array. the resulting stream ends when that incoming stream ends.




(
var a, b;
a = Psetp(\freq, Pseq([801, 1008],inf), Pbind(\dur, Pseq([0.5, 0.111, 0.22])));
x = a.asStream;
9.do({ x.next(Event.new).postln; });
)


Psetp overrides incoming values:

(
var a, b;
a = Psetp(\freq, 801, Pbind(\freq, 108));
x = a.asStream;
9.do({ x.next(Event.new).postln; });
)



sound example

(
SynthDef(\sinegrain, 
	{ arg out=0, freq=440, sustain=0.02;
		var env;
		env = EnvGen.kr(Env.perc(0.001, sustain), 1, doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env * 0.1))
	}).add;
)

(
a = Pbind(\dur, Pseq([0.5, 0.3, 0.1]), \instrument, \sinegrain);
a = Psetp(\freq, Pseq([500, 600, 700], inf), a);
a.play;
)






