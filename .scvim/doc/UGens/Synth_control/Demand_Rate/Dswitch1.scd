Dswitch1			 demand rate generator for switching between inputs

superclass: DUGen


	*new(array, index)
		
		array	array of values or other ugens
		index	which of the inputs to return
		
	structurally related: Pswitch1
	see also: Demand	
	
	
	// example
	
	(
	{ 
		var a, freq, trig;
		a = Dswitch1([1, 3, MouseY.kr(1, 15), 2, Dwhite(0, 3, 2)], MouseX.kr(0, 4));
		trig = Impulse.kr(3);
		freq = Demand.kr(trig, 0, a) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)
	
	(
	{ 
		var a, freq, trig;
		a = Dswitch1({ |i| Dseq((0..i*3), inf) } ! 5, MouseX.kr(0, 4));
		trig = Impulse.kr(6);
		freq = Demand.kr(trig, 0, a) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)	
	
		
	
		
	
	


