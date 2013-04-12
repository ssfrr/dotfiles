Pbindef 			incremental event pattern reference definition

superclass: Pdef



Pbindef keeps a reference to a Pbind in which single keys can be replaced, combining PbindProxy and Pdef.
It plays on when the old stream ended and a new stream is set and schedules the changes to the beat.

the difference to Pdef is that it allows to incrementally change the elementary patterns (patternpairs)
of a Pbind - also of an already existing Pbind inside a Pdef.

Pbindef inherits most methods from Pdef.
Overview: JITLib

*new(key, paramKey1, pattern1, ... )

store the pattern in the global dictionary of Pdef under key.
(if there is already a Pdef there, replace its pattern with the new one. If there is already a Pbindef there, set the parameters only, or add a new one (the whole pattern is replaced).


*new(key)

acess the pattern at that key (if none is there, a default pattern is created)
see Pdef




// example:

(
SynthDef("Pdefhelp", { arg out, freq, sustain=1, amp=1, pan;
var env, u=1;
env = EnvGen.kr(Env.perc(0.01, sustain), 1, doneAction:2);
5.do { var d; d = exprand(0.01, 1); u = SinOsc.ar(d * 300, u, rrand(0.1,1.2) * d, 1) };
Out.ar(out, Pan2.ar(SinOsc.ar(u + 1 * freq, 0, amp * env), pan));

}).store;
)
s.boot;


Pbindef(\a, \instrument, \Pdefhelp).play;
Pbindef(\a, \degree, Pseq([0, 2, 5b, 1b], inf));
Pbindef(\a, \dur, 0.1);
Pbindef(\a, \degree, Pseq([1b, 5, 3, 1b, 6, 2, 5, 0, 3, 0, 2], inf));
Pbindef(\a, \legato, Prand([1.0, 2.4, 0.2], inf), \mtranspose, -3);
Pbindef(\a, \mtranspose, nil); // remove key

Pbindef(\a, \degree, Pseq([1, 2, 3, 4, 5, 6], 1));
Pbindef(\a, \degree, Pseq([1, 2, 3, 4, 5, 6], 3), \dur, 0.02);
Pbindef(\a, \degree, Pseq([1, 2, 3, 4, 5, 6], 3), \dur, 0.1);

// apart from this Pbindef behaves like Pdef:

Pbindef(\a).quant = 0.0;
Pbindef(\a, \degree, Pseq([1, 2, 3, 4, 5, 6], 1));

Pbindef(\a).stop;
Pbindef(\a, \degree, Pseq([1, 2, 3, 4, 5, 6], 1)); // does not resume now

Pbindef(\a).playOnce; // play single instance
Pseq([Pbindef(\a), Pdef(\a)]).play; // same here (Pdef(\a) is the same pattern as Pbindef))

Pbindef(\a) === Pdef(\a) // identical.



// an already existing Pdef can be incrementally changed

Pdef(\x, Pbind(\instrument, \Pdefhelp, \dur, 0.3));
Pdef(\x).play;

Pbindef(\x, \degree, 7.rand);
Pbindef(\x, \degree, Pseq([0, 7, 3, 7, 4], inf), \dur, Pn(Pseries(0.2, -0.02, 10)));
Pbindef(\x, \stretch, 2);







