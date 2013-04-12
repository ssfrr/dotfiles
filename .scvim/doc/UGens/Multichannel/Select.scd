Select				select one output from many sources


superclass: UGen

The output is selected from an array of inputs.

	Select.ar(which, array)
	Select.kr(which, array)


// examples 
(
{
	var a, cycle;
	a = [
			SinOsc.ar,
			Saw.ar,
			Pulse.ar
		];
	cycle = a.size  * 0.5;
	Select.ar(LFSaw.kr(1.0,0.0,cycle,cycle),a) * 0.2
}.play;
)
	
Note: all the ugens are continously running. This may not be the most efficient way if each input is  cpu-expensive.

	

// used as a sequencer 
(
{ 
	var a, cycle;
	a = Array.fill(32, { rrand(30,80) }).midicps;
	a.postln;
	cycle = a.size  * 0.5;
	Saw.ar(
			Select.kr( 
				LFSaw.kr(1.0, 0.0, cycle, cycle),
				a
			),
			0.2	
	);
}.play;
)


Note that the array is fixed at the time of writing the SynthDef, and the whole array is embedded in the SynthDef file itself.  For small arrays this is more efficient than reading from a buffer.


	


