Psync			synchronise and limit pattern duration

superclass:  FilterPattern


	*new(pattern, min, max, tolerance)
			pattern: 		a pattern that returns events
			min:			beat duration for ending patterns
			max:		maximum length of pattern
			tolerance:	difference threshhold that a pattern must exceed max to be ended




(
SynthDef(\help_sinegrain, 
	{ arg out=0, freq=440, sustain=0.05, pan;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.3), doneAction:2);
		Out.ar(out, Pan2.ar(SinOsc.ar(freq, 0, env), pan))
	}).add;
)

s.boot;


// example:


(
// a fixed duration pattern:

f = Pbind(
				\dur, 0.5,
				\degree, Pn(4,1),
				\instrument, \help_sinegrain
			);
			
// this pattern has indetermined length:
a = Prand([
			Pbind(
				\dur, Pseq([0.02, 0.002, 0.1, 0.1],2),
				\degree, Pseq([9, 7, 5],inf),
				\instrument, \help_sinegrain
			),
			Pbind(
				\dur, Pseq([1, 0.35],2),
				\degree, Pseq([0, [2b,5b]],inf),
				\instrument, \help_sinegrain
			),
			Pbind(
				\dur, Pseq([0.15, 0.25, 1.3],2),
				\degree, Pseq([2b,4,5b],inf),
				\instrument, \help_sinegrain
			)
		]);
)

Pseq([f, f, a, a], inf).play; // play a sequence


// Psync allows to limit the duration of a stream relative to a beat grid

b = Psync(a, 1, 1); // create a sequence of exactly 1 beat elements
Pseq([f, f, b, b], inf).play; 


b = Psync(a, 1, 2); // create a sequence of elements of either 1 or 2 beats length
Pseq([f, f, b, b], inf).play; 

(
b = Psync(a, 2);	// create a sequence of elements with a minimum of 2 beats, 
				// but with undetermined upper limit
Ppar([
	Pseq([f, f, b, b], inf), // sequence
	Pbind(\instrument, \help_sinegrain, \freq, 1000, \sustain, 0.01, \dur, 2) // metronome
]).play; 
)




