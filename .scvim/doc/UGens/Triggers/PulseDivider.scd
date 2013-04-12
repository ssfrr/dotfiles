PulseDivider		pulse divider

PulseDivider.ar(trig, div, startCount)

Outputs one impulse each time it receives a certain number of triggers at its input.
trig - trigger. Trigger can be any signal. A trigger happens when the signal changes from
non-positive to positive.
div - number of pulses to divide by.
startCount - starting value for the trigger count. This lets you start somewhere in the middle of a count,
or if startCount is negative it adds that many counts to the first time the output is triggers.


SynthDef("help-PulseDivider",{ arg out=0;
	var p, a, b;
	p = Impulse.ar(8);
	a = SinOsc.ar(1200, 0, Decay2.ar(p, 0.005, 0.1));
	b = SinOsc.ar(600,  0, Decay2.ar(PulseDivider.ar(p, 4), 0.005, 0.5));
	
	Out.ar(out,(a + b) * 0.4)
}).play;


