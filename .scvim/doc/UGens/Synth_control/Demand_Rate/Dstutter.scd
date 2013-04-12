Dstutter			demand rate input replicator

superclass: ListDUGen


	*new(n, in)
		
		n		number of repeats (can be a demand ugen)
		in		input ugen
		
	structurally related: Pstutter
	see also: Demand	
	
	
	// example
	
	(
	{ 
		var freq, trig;
		var in = Dseq([1, 2, 3], inf);
		var rep = Dstutter(Diwhite(2, 8, inf), in);
		trig = Impulse.kr(MouseX.kr(1, 40, 1));
		freq = Demand.kr(trig, 0, rep).poll(trig) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)


