Pmulpre				multiplies with value of a key in event stream, before it is passed up

superclass: FilterPattern

Pset(name, value, pattern)

multiplies with a value in an event, before it is passed up the stream.
to multiply with the value after it has been passed down, use Pmul


(
var a, b;
a = Pmulpre(\note, 2, Pbind(\note, Pseq([1, 2, 3])));
x = a.asStream;
9.do({ x.next(Event.default).postln; });
)

Pmulpre does not override incoming values:

(
var a, b;
a = Pmulpre(\freq, 801, Pset(\freq, 500, Pbind(\dur, 0.2)));
x = a.asStream;
9.do({ x.next(Event.default).postln; });
)

value can be a pattern or a stream. the resulting stream ends when that incoming stream ends

(
var a, b;
a = Pmulpre(\freq, Pseq([401, 801], 2), Pbind(\dur, 0.5));
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
a = Pbind(\dur, 0.5, \instrument, \sinegrain);
b = Pmulpre(\freq, Pseq([1, 2, 3], inf), a);
b.play;
)






