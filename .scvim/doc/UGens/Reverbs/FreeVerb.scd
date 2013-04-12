FreeVerb	A reverb

FreeVerb.ar(in, mix, room, damp, mul, add)

coded from experiments with faust.

Valid parameter range from 0 to 1. Values outside this range are clipped by the UGen.

in - input signal.
Mix - dry/wet balance. range 0..1
room - room size. rage 0..1
damp - Reverb HF damp. range 0..1

See also [FreeVerb2]


Examples

Server.default = s = Server.internal;
s.boot;

// FreeVerb - 1x1 ugen
(
z = SynthDef(\src, {|mix = 0.25, room = 0.15, damp = 0.5|
	Out.ar(0,
		FreeVerb.ar(
			Decay.ar(Impulse.ar(1), 0.25, LFCub.ar(1200,0,0.1)), // mono src
			mix, // mix 0-1
			room, // room 0-1
			damp // damp 0-1 duh
		) ! 2 //fan out...
	);
}).play
)
z.set(\room, 0.7)
z.set(\mix, 0.4)
z.set(\damp, 0.2)

z.free

//it expands as any ugen does
(
z = SynthDef(\src, {|mix = 0.25, room = 0.15, damp = 0.5|
	Out.ar(0,
		FreeVerb.ar(
			Pan2.ar(
				Decay.ar(Impulse.ar(1), 0.25, LFCub.ar(1200,0,0.1)),
				LFNoise1.ar(1).range(-1,1)
			),
			mix,
			room,
			damp
		)
	);
}).play
)
z.set(\room, 0.7)
z.set(\mix, 0.4)
z.set(\damp, 0.2)

z.free



