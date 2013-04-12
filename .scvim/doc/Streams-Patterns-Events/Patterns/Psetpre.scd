Psetpre					set values of one key in an event before it is passed up

superclass: FilterPattern

Pset(name, value, pattern)

sets a value in an event, before it is passed up the stream.
to set the value after it has been passed to the stream, use Pset


(
var a, b;
a = Psetpre(\freq, 801, Pbind(\dur, 0.5));
x = a.asStream;
9.do({ x.next(Event.new).postln; });
)

Psetpre does not override incoming values:

(
var a, b;
a = Psetpre(\freq, 801, Pbind(\freq, 108));
x = a.asStream;
9.do({ x.next(Event.new).postln; });
)

value can be a pattern or a stream. the resulting stream ends when that incoming stream ends

(
var a, b;
a = Psetpre(\freq, Pseq([401, 801], 2), Pbind(\dur, 0.5));
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
a = Psetpre(\freq, Pseq([500, 600, 700], inf), a);
a = Psetpre(\legato, Pseq([0.01, 1],inf), a);
a.play;
)




