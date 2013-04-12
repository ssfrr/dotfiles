ControlRate			server control rate

superclass: InfoUGenBase

returns the current control rate of the server

	*ir
	
	
equivalent to  1 / ControlDur

	
// example

{ ControlRate.ir.poll }.play;

// play a sine tone at control rate

{ SinOsc.ar(ControlRate.ir) * 0.1 }.play;


