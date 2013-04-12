Trig1		timed trigger

Trig1.ar(in, dur)
Trig1.kr(in, dur)

When a nonpositive to positive transition occurs at the input, Trig outputs 1.0 for the specified duration, otherwise it outputs zero.

trig - trigger. Trigger can be any signal. A trigger happens when the signal changes from non-positive to positive.
dur - duration of the trigger output. (Default 0.1)


{ Trig1.ar(Dust.ar(1), 0.2) * FSinOsc.ar(800, 0, 0.5) }.play


To create a fixed duration gate
(

SynthDef("trig1",{ arg dt = 0.125;
	var gate;
	gate = Trig1.kr(1.0, dt);
	OffsetOut.ar(0,
		SinOsc.ar(800, 0.3) 
		* EnvGen.kr(
			Env([0,0.1,0.1,0],[0.01,1.0,0.01],[-4,4],2),
			gate,
			doneAction: 2)
	)
}).send(s);

Routine({
	1.0.wait;
	100.do({
		s.sendBundle(0.05,["s_new", "trig1" ,-1,0,0,0,rrand(0.02,0.25)]);
		0.25.wait
	})
}).play(SystemClock)

)

This should sound like a continous sine wave, although it is actually a series of 0.25 second synths.
(
SynthDef("trig1",{
	var gate;
	gate = Trig1.kr(1.0, 0.25);
	OffsetOut.ar(0,
		SinOsc.ar(800, 0.3) 
		* EnvGen.kr(
			Env([0,0.1,0.1,0],[0.01,1.0,0.01],[-4,4],2),
			gate,
			doneAction: 2)
	)
}).send(s);

Routine({
	1.0.wait;
	100.do({
		s.sendBundle(0.05,["s_new", "trig1" ,-1]);
		0.25.wait
	})
}).play(SystemClock)

)



