Dseries		 demand rate arithmetic series ugen

superclass: DUGen


	*new(start, step, length)
		
		start		start value
		step 	step value
		length	number of values to create
		The arguments can be a number or any other ugen
	
	
	structurally related: Pseries	
	see also: Demand
	
	// example
	
	(
	{ 
		var a, freq, trig;
		a = Dseries(0, 1, 15);
		trig = Impulse.kr(MouseX.kr(1, 40, 1));
		freq = Demand.kr(trig, 0, a) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)
	
	(
	{ 
		var a, freq, trig;
		a = Dseries(0, 1, inf);
		trig = Dust.kr(MouseX.kr(1, 40, 1));
		freq = Demand.kr(trig, 0, a) % 15 * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)
	
		
	
	


