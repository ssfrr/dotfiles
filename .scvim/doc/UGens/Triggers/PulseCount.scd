PulseCount		pulse counter

PulseCount.ar(trig, reset)

Each trigger increments a counter which is output as a signal.
trig - trigger. Trigger can be any signal. A trigger happens when the signal changes from
non-positive to positive.
reset - resets the counter to zero when triggered.


SynthDef("help-PulseCount",{ arg out=0;
	Out.ar(out,
		SinOsc.ar(
			PulseCount.ar(Impulse.ar(10), Impulse.ar(0.4)) * 200, 
			0, 0.05
		)
	)
}).play;


