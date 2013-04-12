Dgeom		 demand rate geometric series ugen

superclass: DUGen


	*new(start, grow, length)
		
		start		start value
		grow 	value by which to grow ( x = x[-1] * grow )
		length	number of values to create
		
	structurally related: Pgeom	
	The arguments can be a number or any other ugen
	
	
	// example
	
	(
	{ 
		var a, freq, trig;
		a = Dgeom(1, 1.2, 15);
		trig = Impulse.kr(MouseX.kr(1, 40, 1));
		freq = Demand.kr(trig, 0, a) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)
	
	(
	{ 
		var a, freq, trig;
		a = Dgeom(1, 1.2, inf);
		trig = Dust.kr(MouseX.kr(1, 40, 1));
		freq = Demand.kr(trig, 0, a) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)
	
		
	
	


