Dswitch			 demand rate generator for embedding different inputs

superclass: Dswitch1


	*new(array, index)
		
		array	array of values or other ugens
		index	which of the inputs to return
		
	structurally related: Pswitch
	see also: Demand, Duty	
	
	In difference to Dswitch1, Dswitch embeds all items of 
	an input demand ugen first before looking up the next index.
	
	// example
	
	(
		{ 
			var d, trig;
			d = Dswitch([
				Dwhite(3, 4, 2),
				Dwhite(0, 1, 2),
				Dseq([1, 1, 1, 0], 2)
			], Dseq([0, 1, 2, 1, 0], 2));
			
			trig = Impulse.kr(4);
			
			SinOsc.ar(
				Demand.kr(trig, 0, d).poll(trig)
				* 300 + 400
			) 
			* 0.1 ! 2
		}.play;
	);
	
	// compare with Dswitch1:
	
	(
		{ 
			var d, trig;
			d = Dswitch1([
				Dwhite(3, 4, 2),
				Dwhite(0, 1, 2),
				Dseq([1, 1, 1, 0], 2)
			], Dseq([0, 1, 2, 1, 0], 2));
			
			trig = Impulse.kr(4);
			
			SinOsc.ar(
				Demand.kr(trig, 0, d).poll(trig)
				* 300 + 400
			) 
			* 0.1 ! 2
		}.play;
	);

				
			
		
	
	


