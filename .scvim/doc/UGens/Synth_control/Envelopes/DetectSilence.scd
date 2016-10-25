DetectSilence			when input falls below a threshold, evaluate doneAction

superclass: UGen
	
*ar(input, amp, time, doneAction) 
*kr(input, amp, time, doneAction) 

		
	input - any source
	amp - when input falls below this, evaluate doneAction
	time	- the minimum duration of the for which input must fall below thresh before this triggers. The default is 0.1 seconds.
	doneAction - an integer representing a done action. See UGen-doneActions for more detail.


If the signal input starts with silence at the beginning of the synth's duration, then DetectSilence will wait indefinitely until the first sound before starting to monitor for silence. 

This UGen outputs 1 if silence is detected, otherwise 0. 

	//example
	
	(
	SynthDef("detectSilence-help", { arg out;
		var z;
		z = SinOsc.ar(Rand(400, 700), 0, LFNoise2.kr(8, 0.2).max(0));
		DetectSilence.ar(z, doneAction:2);
		Out.ar(out, z);
	}).send(s);
	)
	
	s.sendMsg("/s_new", "detectSilence-help", -1);
	s.sendMsg("/s_new", "detectSilence-help", -1);
	s.sendMsg("/s_new", "detectSilence-help", -1);

	(
	Task({
		loop({
			s.sendMsg("/s_new", "detectSilence-help", -1);
			[0.5, 1].choose.wait;
		})
	}).play;
	)
	
	


