Drand, Dxrand			 demand rate random sequence generators

superclass: ListDUGen


	*new(array, length)
		
		array	array of values or other ugens
		length	number of values to return
		
	structurally related: Prand
	see also: Demand	
	
	Dxrand never plays the same value twice, whereas Drand chooses any value in the list
	
	// example
	
	(
	{ 
		var a, freq, trig;
		a = Drand([1, 3, 2, 7, 8], inf);
		trig = Impulse.kr(MouseX.kr(1, 400, 1));
		freq = Demand.kr(trig, 0, a) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)
	
	(
	{ 
		var a, freq, trig;
		a = Dxrand([1, 3, 2, 7, 8], inf);
		trig = Impulse.kr(MouseX.kr(1, 400, 1));
		freq = Demand.kr(trig, 0, a) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)
	
	
		
	
		
	
	


