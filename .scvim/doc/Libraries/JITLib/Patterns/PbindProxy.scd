PbindProxy 			incremental event pattern reference

superclass: Pattern




keeps a reference to a Pbind in which single keys can be replaced.
It plays on when the old stream ended and a new stream is set and schedules the changes to the beat.

related [Pbindef][Pdef]



*new(key1, pattern1, key2, pattern2, ... )
		create a new instance of PbindProxy with the given patternpairs

source
		returns the wrapper for the Pbind


set(key1, pattern1, key2, pattern2, ... )
		set the given patternpairs.

at(key)
		return a pattern at that key. this can be used to set quant value individually,
		so different elementary patterns can be quantized differently.

	x.at(\freq).quant = 2;



quant_(val)
		set the quant of all elementary patterns


quant
		return the quant value of the source pattern


// example:

(
SynthDef("Pdefhelp", { arg out, freq, sustain=1, amp=1, pan;
var env, u=1;
env = EnvGen.kr(Env.perc(0.03, sustain), 1, doneAction:2);
5.do { var d; d = exprand(0.01, 1); u = SinOsc.ar(d * 300, u, rrand(0.1,1.2) * d, 1) };
Out.ar(out, Pan2.ar(SinOsc.ar(u + 1 * freq, 0, amp * env), pan));

}).store;
)
s.boot;


x = PbindProxy.new;
x.set(\instrument, \Pdefhelp);

x.play;

x.set(\degree, Pseq([0, 2, 5b, 1b], inf));
x.set(\dur, 0.1);
x.set(\degree, Pseq([1b, 5, 3, 1b, 6, 2, 5, 0, 3, 0, 2], inf));
x.set(\legato, Prand([1.0, 2.4, 0.2], inf), \mtranspose, -3);
x.set(\mtranspose, nil); // remove key

x.set(\degree, Pseq([1, 2, 3, 4, 5, 6], 1));
x.play;

x.set( \degree, Pseq([1, 2, 3, 4, 5, 6], 3), \dur, 0.02);
x.play;

x.set(\degree, Pseq([1, 2, 3, 4, 5, 6], 3), \dur, 0.1);
x.play;


// embed in other patterns:
(
x.set(\degree, Pseq([1b, 5, 3, 1b, 6, 2, 5, 0, 3, 0, 2], inf));
Ppar([
x,
Pbindf(x, \ctranspose, 4)
]).play;
)


x.set(\degree, Pseq([1b, 5, 1b, 4, 0], inf), \dur, 0.4);





