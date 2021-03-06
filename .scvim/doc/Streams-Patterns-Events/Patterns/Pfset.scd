Pfset			insert an environment into the event prototype before evaluating the supplied pattern.

superclass: FuncFilterPattern

Good for setting default values or loading server objects.

Pfset(func, pattern, cleanupFunc)


func: Use environment variable syntax (e.g., ~x = 0) to store values in the internal environment. These values are copied into the event prototype before running the supplied pattern.

pattern: An event pattern (such as Pbind).

cleanupFunc: Optional. A function to evaluate when the pattern is stopped, or when the supplied pattern runs out of values. For example, if you loaded a Buffer in the initializer function, you could free it in the cleanupFunc.

(
var a, b;
a = Pfset({
	~legato = 0.3;
	~detune = rrand(0, 30);
}, Pbind(\dur, 0.5));
x = a.asStream;
9.do({ x.next(Event.new).postln; });
)

Pfset does not override values placed into the event by the inner pattern:


(
var a, b;
a = Pfset({
	~dur = 0.3;
}, Pbind(\dur, 0.5));
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
a = Pbind(\dur, 0.5, \instrument, \sinegrain, \x, Pfunc { rrand(500, 600) });
a = Pfset({ ~freq = { ~x.postln * 2 }; ~legato = 3; },  a);
a.play;
)




