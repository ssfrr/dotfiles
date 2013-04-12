Dser			 demand rate sequence generator

superclass: ListDUGen


	*new(array, length)
		
		array	array of values or other ugens
		length	number of values to return
		
	structurally related: Pser
	see also: Demand	
	
	
	// example
	
	(
	{ 
		var a, freq, trig;
		a = Dser([1, 3, 2, 7, 8], 8);
		trig = Impulse.kr(MouseX.kr(1, 40, 1));
		freq = Demand.kr(trig, 0, a) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)
	
	
		
	
		
	
	


