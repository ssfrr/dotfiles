Pindex			pattern that indexes into an array

Pindex(list, index, repeats)

This allows an ArrayedCollection to be accessed within patterns. 

list 		is the array and index the value to retrieve - both of these arguments can themselves be Patterns.
repeats 	specifies the number of repeats.




// example

(
SynthDef(\help_pindex, { | out, amp=0.1, freq=440, gate=1 |
	var son = Saw.ar(freq * [0.99, 1, 1.01]).mean;
	son = son * EnvGen.ar(Env.adsr, gate: gate, doneAction:2);
	Out.ar(out, son.dup * amp);
}).add;
)


(
var data = [7, 13, 12, 2, 2, 2, 5];
var indices = [0, 0, 2, 0, 4, 6, 7];
Pbind(
	\instrument, \help_pindex,
	\choice, Prand(indices, inf),
	\degree, Pindex(data, Pkey(\choice), inf),
	\dur, 0.7
).play
)



