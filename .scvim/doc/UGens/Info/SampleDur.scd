SampleDur			duration of one  sample 

superclass: InfoUGenBase

returns the current sample duration of the server in seconds

	*ir
			

equivalent to  1 / SampleRate

related: minNyquist


// examples

{ SampleDur.ir.poll }.play;
{ (1/SampleDur.ir).poll }.play;

// drive a demand ugen at samplerate

{ Duty.ar(SampleDur.ir, 0, Dbrown(-1.0, 1.0, 0.01, inf)) * 0.1 }.play


