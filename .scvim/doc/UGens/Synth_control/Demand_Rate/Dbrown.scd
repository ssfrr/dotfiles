Dbrown, Dibrown		 demand rate brownian movement generators

superclass: DUGen


	*new(lo, hi, step, length)
		
		lo		minimum value
		hi 		maximum value
		step		maximum step for each new value
		length	number of values to create
	
	Dbrown returns numbers in the continuous range between lo and hi, Dibrown returns integer values
	The arguments can be a number or any other ugen
	
	structurally related: Pbrown, BrownNoise	
	see also: Demand
	
	
	// example
	
	// Dbrown
	(
	{ 
		var a, freq, trig;
		a = Dbrown(0, 15, 1, inf);
		trig = Impulse.kr(MouseX.kr(1, 40, 1));
		freq = Demand.kr(trig, 0, a) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)
	
	
	
	// Dibrown
	
	(
	{ 
		var a, freq, trig;
		a = Dibrown(0, 15, 1, inf);
		trig = Impulse.kr(MouseX.kr(1, 40, 1));
		freq = Demand.kr(trig, 0, a) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)
	
	
		
	
	


