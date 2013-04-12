Linen   			simple linear envelope generator

Inherits from: Object : AbstractFunction : UGen


Linen.kr( gate = 1.0, attackTime = 0.01, susLevel = 1.0, releaseTime = 1.0, doneAction = 0 )

See UGen-doneActions and EnvGen for more detail.


// triggered

{ Linen.kr(Impulse.kr(2), 0.01, 0.6, 1.0, doneAction: 0) * SinOsc.ar(440, 0, 0.1)}.play;

// play once and end the synth

{ Linen.kr(Impulse.kr(0), 0.01, 0.6, 1.0, doneAction: 2) * SinOsc.ar(440, 0, 0.1)}.play;

// play once and sustain
(
x = { arg gate = 1, out = 0; // use gate arg for release
		Linen.kr(gate, 0.01, 0.6, 1.0, doneAction: 2) * SinOsc.ar(440, 0, 0.1)
}.play;
)		
x.release(4); // change the release time

// longer gate, can pass in sustain
(
x = { arg out = 0, sustain = 2;
	var gate;
	gate = Trig.kr(1.0, sustain);
		Linen.kr(gate, 0.01, 0.6, 1.0, doneAction: 2) * SinOsc.ar(440, 0, 0.1)
}.play;
)



// used below in a Routine varying the releaseTime
(
SynthDef(\help_Linen, { arg out=0, freq=440, attackTime=0.01, susLevel=0.6, releaseTime=0.1;
	Out.ar(out, 
		Linen.kr(Impulse.kr(0), attackTime, susLevel, releaseTime, doneAction: 2)
			* SinOsc.ar(freq, 0, 0.1)
	)
}).send(s);
)

(
// Debussy sleeping through math class
x = Pbrown(0.01, 2.0, 0.2, inf).asStream;
Routine({
	loop({
		Synth.grain(\help_Linen, [\freq, (rrand(20, 50) * 2).midicps, \releaseTime, x.next]);
		0.25.wait;
	})
}).play(TempoClock.default)
)

(
{ Linen.kr(Impulse.kr(2), 
			0.01, 
			// sustain level is polled at time of trigger
			FSinOsc.kr(0.1).range(0, 1), 
			1.0, 
			doneAction: 0)
			
			* SinOsc.ar(440, 0, 0.1)
}.play
);


