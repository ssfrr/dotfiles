Pset					event pattern that sets values of one key

superclass: FilterPattern

Pset(name, value, pattern)

Pset sets a value in an event stream. It acts like one key in a Pbindf


(
var a, b;
a = Pset(\freq, 801, Pbind(\dur, 0.5));
x = a.asStream;
9.do({ x.next(Event.new).postln; });
)

Pset overrides incoming values:

(
var a, b;
a = Pset(\freq, 801, Pbind(\freq, 108));
x = a.asStream;
9.do({ x.next(Event.new).postln; });
)

value can be a pattern or a stream. the resulting stream ends when that incoming stream ends

(
var a, b;
a = Pset(\freq, Pseq([401, 801], 2), Pbind(\dur, 0.5));
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
a = Pset(\freq, Pseq([500, 600, 700], inf), a);
a = Pset(\legato, Pseq([0.01, 1],inf), a);
a.play;
)




