Pswitch1 		embed values in a list according to a pattern of indices


Pswitch1(list, which)

Pswitch1 chooses elements from the list by a stream of indices (which) and embeds them in the stream.
If the element is itself a pattern, it embeds only one of its values for each index, and thus switches between all patterns in the list.

see also: Pswitch

(
var a, b;
a = Pseq([1, 2, 3], inf);
b = Pseq([65, 76], inf);
c = Pswitch1([a, b, 800], Pseq([2, 2, 0, 1], inf));
x = c.asStream;
24.do({ x.next.postln; });
)


Pswitch used as a sequence of pitches:


(
SynthDef(\help_sinegrain, 
	{ arg out=0, freq=440, sustain=0.05;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env))
	}).add;
)



(
a = Pseq([73, 71, 69], inf);
b = Pseq([0, 0, 0, 4, 0]+64, inf);
c = Pswitch1([a, b, 75], Pseq([2, 2, 0, 1], inf));
x = c.asStream;
Routine({
	loop({
	Synth(\help_sinegrain, [\freq, x.next.midicps]);
	0.18.wait;
	})
}).play;
)




