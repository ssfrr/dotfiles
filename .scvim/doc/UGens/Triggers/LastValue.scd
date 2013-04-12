LastValue 			

LastValue.ar(in, diff)
LastValue.kr(in, diff)

output the last value before the input changed more than a threshhold


	in	input
	diff 	difference threshhold 


	d = { arg freq=440; SinOsc.ar(LastValue.ar(freq, 20), 0, 0.2) }.play;

	d.set(\freq, 400);
	d.set(\freq, 200);
	d.set(\freq, 670);
	d.set(\freq, 680);
	d.set(\freq, 695);
	d.free;
	
	
	
	return the difference between currrent and the last changed 
	
	(
	d = { arg out=0, val=1;
		SinOsc.ar(
				abs(val - LastValue.kr(val)) * 400 + 200, 
				0, 0.2
		)
	}.play;
	)
	
	d.set(\val, 3);
	d.set(\val, 2);
	d.set(\val, 0.2);
	d.set(\val, 1);
	d.set(\val, 2);
	d.free;
	


