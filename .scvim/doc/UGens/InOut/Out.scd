Out				write a signal to a bus

Inherits from: Object : AbstractFunction : UGen : AbstractOut

*ar(bus, channelsArray)  - write a signal to an audio bus.
*kr(bus, channelsArray)  - write a signal to a control bus.
	
bus - the index, or array of indexes, of busses to write to. The lowest index numbers are written to the audio hardware.
channelsArray - an Array of channels or single output to write out. You cannot change the size of this once a SynthDef has been built.

N.B. Out is subject to control rate jitter. Where sample accurate output is needed, use OffsetOut.		
Note that using the Bus class to allocate a multichannel bus simply reserves a series of adjacent bus indices with the Server object's bus allocators. abus.index simply returns the first of those indices. When using a Bus with an In or Out ugen there is nothing to stop you from reading to or writing from a larger range, or from hardcoding to a bus that has been allocated. You are responsible for making sure that the number of channels match and that there are no conflicts.
When using an array of bus indexes, the channel array will just be copied to each bus index in the array. So Out.ar([bus1,bus2],channelsArray) will be the same has Out.ar(bus1,channelsArray) + Out.ar(bus2,channelsArray). 

See the Server-Architecture and Bus helpfiles for more information on buses and how they are used.

	// mono
	(
	SynthDef(\help_out, { arg out=0, freq=440;
		var source;
			source = SinOsc.ar(freq, 0, 0.1);

			// write to the bus, adding to previous contents
			Out.ar(out, source);

	}).send(s);
	)
	
	
	Synth(\help_out, [\freq, 500]);
	Synth(\help_out, [\freq, 600]);
	Synth(\help_out, [\freq, 700]);
	
	//stereo
	(
	SynthDef(\help_out2, { arg out=0, freq=440;
		var source;
			source = SinOsc.ar([freq, freq+1.0], 0, 0.1); // stereo

			// write channel array to the busses starting at bus 0, then bus 1
			Out.ar(out, source);

	}).send(s);
	)	
	
	Synth(\help_out2, [\freq, 500]);
	
	//Multiple busses, mono source
	(
	SynthDef(\help_out3, { arg freq=440;
		var source;
			source = SinOsc.ar(freq, 0, 0.1); // stereo

			// write output to bus 0 and bus 2
			Out.ar([0,2], source);

	}).send(s);
	)	
	
	Synth(\help_out3, [\freq, 500]);
	
	//Multiple busses, multichannel source
	(
	SynthDef(\help_out4, { arg freq=440;
		var source;
			source = SinOsc.ar([freq,freq+1], 0, 0.1); // stereo

			// write output to bus 0 and bus 2
			Out.ar([0,2], source);

	}).send(s);
	)	
	
	Synth(\help_out4, [\freq, 500]);
	
	




