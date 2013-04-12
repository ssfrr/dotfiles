Dwhite, Diwhite		demand rate white noise random generators

superclass: DUGen


	*new(lo, hi, length)
		
		lo		minimum value
		hi 		maximum value
		length	number of values to create
	
	Dwhite returns numbers in the continuous range between lo and hi, Diwhite returns integer values
	The arguments can be a number or any other ugen
	
	structurally related: Pwhite, WhiteNoise
	see also: Demand	
	
	
	// example
	
	// Dwhite
	(
	{ 
		var a, freq, trig;
		a = Dwhite(0, 15, inf);
		trig = Impulse.kr(MouseX.kr(1, 40, 1));
		freq = Demand.kr(trig, 0, a) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)	
	
	
	// Diwhite
	
	(
	{ 
		var a, freq, trig;
		a = Diwhite(0, 15, inf);
		trig = Impulse.kr(MouseX.kr(1, 40, 1));
		freq = Demand.kr(trig, 0, a) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)
	
	
	
	// Dwhite and Diwhite
	(
	{ 
		var a, freq, trig;
		a = Dwhite(0, Dseq([Dgeom(1, 1.01, Diwhite(50, 800, inf))], inf) - 1, inf);
		freq = Duty.kr(SampleDur.ir, 0, a) + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)

	
	


