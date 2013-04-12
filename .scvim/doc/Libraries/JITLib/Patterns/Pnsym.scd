Pnsym 		use a pattern of symbols to embed Pdefn's

superclass: Psym

for event patterns see Psym
Overview: JITLib
Related: Pdefn
 
Pnsym(pattern)
	pattern: a pattern that returns symbols or characters. Arrays are converted to parallel patterns (Ptuple).
	dict:  the dictionary to be used for lookup. By default, this is Pdefn.all, so one can embed Pdefns by name.
	

dict_(a dictionary)
	set the dictionary to be used




// example:

(
// load a synthdef
s.boot;
SynthDef("gpdef", 
	{ arg out=0, freq=440, sustain=0.05, amp=0.1, pan;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain), doneAction:2) * amp;
		Out.ar(out, Pan2.ar(SinOsc.ar(freq, 0, env), pan))
	}).store;
)

Pdefn(\x, Pn(1, 3)); 
Pdefn(\y, Prand([5, 9, 1], 2));
Pdefn(\z, Pdefn(\y) * 2);

(
Pdef(\play, 
	Pbind(
		\instrument, \gpdef,
		\harmonic, Pnsym(Pseq([\x, \x, Prand([\x, \y]), [\z, \y], \y], inf)).trace,
		\dur, 0.2, \note, 10
	)
).play;
)

// change root pattern:
Pdefn(\x, Pn(2, 3));
Pdefn(\x, Pseq([1, 3, 1, 2, 1, 4, 5]));
Pdefn(\x, Pseq([1, 3, 1, 2, [1, 3], 4, 5]));



