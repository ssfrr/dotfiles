Ptuple 				combine a list of streams to a stream of lists

superclass: ListPatterns

Ptuple(list, repeats)
	list: 		an Array of Patterns
	repeats: 	an Integer or inf
	
At each iteration, Ptuple returns a tuple (array) combining the output of each of the patterns in the list.  When any of the patterns returns a nil, Ptuple ends that 'repeat' and restarts all of the streams.

(
var a, b;
a = Pseq([1, 2, 3], inf);
b = Pseq([65, 76], inf);
c = Ptuple([a, a, b], inf);
x = c.asStream;
8.do({ x.next.postln; });
)


(
var a, b;
a = Pseq([1, 2, 3], inf);
b = Pseq([65, 76], 3); // stops after 3 cycles
c = Ptuple([a, a, b], 4); // stops after 4 cycles
x = c.asStream;
8.do({ x.next.postln; });
)


Ptuple used as a sequence of pitches (chords)


(
SynthDef(\help_sinegrain, 
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).add;
)

(
a = Pseq([73, 71, 69, 69, 65, 64], inf);
b = Pseq([0, 0, 0, 4, 0, 3, 2], inf) + a;
c = Ptuple([a, b], inf);
x = c.asStream;
Routine({
	var chord;
	loop({
		chord = x.next.postln.midicps;
		(instrument: \help_sinegrain, freq: chord).play;
	0.2.wait;
	})
}).play;
)




