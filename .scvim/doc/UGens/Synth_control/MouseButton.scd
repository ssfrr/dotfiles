MouseButton		 mouse button ugen

superclass: UGen


	*kr(minval, maxval, lag)
	
	minval			value when the key is not pressed
	maxval			value when the key is pressed
	
	lag				lag factor
	
	see also MouseX, MouseY
	
	
	
	//example
	
	{ SinOsc.ar(MouseButton.kr(400, 440, 0.1), 0, 0.1) }.play;
	{ SinOsc.ar(MouseButton.kr(400, 740, 2), 0, 0.1) }.play;

	


