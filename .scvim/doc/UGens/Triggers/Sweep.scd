Sweep			triggered linear ramp

superclass: UGen

starts a linear raise by rate/sec from zero when trig input crosses from non-positive to positive 

	*ar(trig, rate)
	*kr(trig, rate)

	


	
// using sweep to modulate sine frequency
(
{ var trig;
	trig = Impulse.kr(MouseX.kr(0.5, 20, 1));
	SinOsc.ar(Sweep.kr(trig, 700) + 500, 0, 0.2)
}.play;
)





// using sweep to index into a buffer

s.sendMsg("/b_allocRead", 0, "sounds/a11wlk01.wav");

(
{ var trig;
	trig = Impulse.kr(MouseX.kr(0.5, 10, 1));
	BufRd.ar(1, 0, Sweep.ar(trig, BufSampleRate.ir(0)))
}.play;
)

// backwards, variable offset

(
{ var trig, pos, rate;
	trig = Impulse.kr(MouseX.kr(0.5, 10, 1));
	rate = BufSampleRate.ir(0);
	pos = Sweep.ar(trig, rate.neg) + (BufFrames.ir(0) * LFNoise0.kr(0.2));
	BufRd.ar(1, 0, pos)
}.play;
)


// raising rate
(
{ var trig, rate;
	trig = Impulse.kr(MouseX.kr(0.5, 10, 1));
	rate = Sweep.kr(trig, 2) + 0.5;
	BufRd.ar(1, 0, Sweep.ar(trig, BufSampleRate.ir(0) * rate))
}.play;
)




