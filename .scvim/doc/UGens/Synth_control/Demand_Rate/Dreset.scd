Dreset			demand rate reset 

The reset of a demand ugen can be controlled "from the outside" by the reset input of the Demand or Duty UGen, which consumes the chain of demands. Dreset allows to reset a subset of the chain internally.

superclass: Object : UGen : DUGen 

*new(in, reset)
		
in - a demand UGen, producing values which are passed through
reset - a demand or any other UGen. When crossing from nonpositive to positive, it resets the first argument.
		
	
	// example
	
	(
	{ 
		var a, freq;
		a = Dreset(Dseries(0, 2, inf), Drand([0, 0, 0, 1], inf));
		freq = Duty.kr(1/MouseX.kr(1, 40, 1), 0, a) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	}.play;
	)
	
	// reset when mouse button is pressed
	(
	{
		var a, freq;
		a = Dreset(Dseries(0, 2, inf), MouseButton.kr);
		freq = Duty.kr(1/MouseX.kr(1, 40, 1), 0, a) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	}.play;
	)
		
	// audio rate
	(
	{ 
		var a, nmax = 90;
		a = { Dreset(Dseries(0, 1, inf), Drand(0 ! nmax ++ 1, inf)) } ! 2;
		Duty.ar(SampleDur.ir, 0, a) * (0.1 / nmax)
	}.play;
	)

	
	


