Pbus 				isolate a pattern by restricting it to a bus

superclass: FilterPattern



Pbus(pattern, dur, fadeTime)

Starts a new group and plays the pattern in this group, on a private bus. 
The group and the bus is released when the stream has ended.

This is useful in order to isolate a Pfx.

dur 				delay to allow inner patterns to decay. 
fadeTime			fading out the inner pattern after dur over this time
numChannels		number of channels of the bus (should match the synthdef) default: 2
rate				bus rate (default: 'audio')




Example:


(
SynthDef(\echo, { arg out=0, maxdtime=0.2, dtime=0.2, decay=2, gate=1;
	var env, in;
	env = Linen.kr(gate, 0.05, 1, 0.1, 2);
	in = In.ar(out, 2);
	XOut.ar(out, env, CombL.ar(in * env, maxdtime, dtime, decay, 1, in));
}, [\ir, \ir, 0.1, 0.1, 0]).add;

SynthDef(\distort, { arg out=0, pregain=40, amp=0.2, gate=1;
	var env;
	env = Linen.kr(gate, 0.05, 1, 0.1, 2);
	XOut.ar(out, env, (In.ar(out, 2) * pregain).distort * amp);
}, [\ir, 0.1, 0.1, 0]).add;

SynthDef(\wah, { arg out=0, gate=1;
	var env, in;
	env = Linen.kr(gate, 0.05, 1, 0.4, 2);
	in = In.ar(out, 2);
	XOut.ar(out, env, RLPF.ar(in, LinExp.kr(LFNoise1.kr(0.3), -1, 1, 200, 8000), 0.1).softclip * 0.8);
}, [\ir, 0]).add;
)

(
var p, q, r, o;
p = Pbind(\degree, Prand((0..7),12), \dur, 0.3, \legato, 0.2);

q = Pfx(p, \echo, \dtime, 0.2, \decay, 3);

r = Pfx(q, \distort, \pregain, 20, \amp, 0.25);

o = Pfx(r, \wah);

Ppar(
	[p, q, r, o].collect(Pbus(_)); // play each in a different bus.
).play;
)	



// compare to playing them together on one bus.
(
var p, q, r, o;
p = Pbind(\degree, Prand((0..7),12), \dur, 0.3, \legato, 0.2);

q = Pfx(p, \echo, \dtime, 0.2, \decay, 3);

r = Pfx(q, \distort, \pregain, 20, \amp, 0.25);

o = Pfx(r, \wah);

Ppar([p, q, r, o]).play;
)



