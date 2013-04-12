MouseY		 cursor ugen

superclass: UGen


	*kr(minval, maxval, warp, lag)
	
	minval, maxval	range between top and low end of screen
	
	warp			mapping curve. 0 is linear, 1 is exponential (for freq or times e.g)
					alternative: 'linear', 'exponential'
	
	lag				lag factor to depipper cursor movement. (Default 0.2)
	
	see also MouseX, MouseButton
	
	
	
	//example
	
	{ SinOsc.ar(MouseY.kr(40, 10000, 1), 0, 0.1) }.play;
	
	
	//xy example
	
	{ SinOsc.ar([MouseX.kr(40, 10000, 1), MouseY.kr(40, 10000, 1)], 0, 0.1) }.play;


