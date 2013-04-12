ControlDur			duration of one block 

superclass: InfoUGenBase

returns the current block duration of the server in seconds

	*ir
			

equivalent to  1 / ControlRate



// examples

{ ControlDur.ir.poll }.play;
{ (1/ControlDur.ir).poll }.play;
{ ControlRate.ir.poll }.play;


