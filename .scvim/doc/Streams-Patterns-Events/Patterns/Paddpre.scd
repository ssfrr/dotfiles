Paddpre					event pattern that adds to existing value of one key

superclass: FilterPattern

Pset(name, value, pattern)

adds a value in an event, before it is passed up the stream.
to add to the value after it has been passed to the stream, use Padd


(
var a, b;
a = Paddpre(\x, 8, Pbind(\dur, 0.5));
x = a.asStream;
9.do({ x.next((\x:4)).postln; });
)

Paddpre does not override incoming values:

(
var a, b;
a = Paddpre(\freq, 302, Pset(\freq, 500, Pbind(\dur, 0.3)));
x = a.asStream;
9.do({ x.next(Event.default).postln; });
)


value can be a pattern or a stream. the resulting stream ends when that incoming stream ends

(
var a, b;
a = Paddpre(\legato, Pseq([0.2, 0.4], 2), Pbind(\dur, 0.5));
x = a.asStream;
9.do({ x.next(Event.default).postln; });
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
a = Pbind(\dur, 0.5, \instrument, \sinegrain);
b = Paddpre(\freq, Pseq([10, 30, 100], inf), a);
b.play;
)






