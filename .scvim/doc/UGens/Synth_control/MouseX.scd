MouseX		 cursor ugen

superclass: UGen


	*kr(minval, maxval, warp, lag)
	
	minval, maxval	range between left and right end of screen
	
	warp			mapping curve. 0 is linear, 1 is exponential (for freq or times e.g)
					alternative: 'linear', 'exponential'
	
	lag				lag factor to dezipper cursor movement. (Default 0.2)
	
	see also MouseY, MouseButton
	
	
	
	//example
	
	{ SinOsc.ar(MouseX.kr(40, 10000, 1), 0, 0.1) }.play;
	
	
	//same but with a 2sec lag
	
	{ SinOsc.ar(MouseX.kr(40, 10000, 'exponential', 2), 0, 0.1) }.play;
	


