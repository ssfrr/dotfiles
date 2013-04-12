Dseq			 demand rate sequence generator

superclass: ListDUGen


	*new(array, length)
		
		array	array of values or other ugens
		length	number of repeats
		
	structurally related: Pseq
	see also: Demand	
	
	
	// example
	
	(
	{ 
		var a, freq, trig;
		a = Dseq([1, 3, 2, 7, 8], 3);
		trig = Impulse.kr(MouseX.kr(1, 40, 1));
		freq = Demand.kr(trig, 0, a) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)
		
	// audio rate
	(
	{ 
		var a, freq, trig;
		a = Dseq({ 10.rand } ! 32, inf);
		trig = Impulse.ar(MouseX.kr(1, 10000, 1));
		freq = Demand.ar(trig, 0, a) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)
	
	


