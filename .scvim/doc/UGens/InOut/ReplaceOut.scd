ReplaceOut		send signal to a bus, overwriting previous contents

Inherits from: Object : AbstractFunction : UGen : AbstractOut : Out

*ar(bus, channelsArray)  - write a signal to an audio bus.
*kr(bus, channelsArray)  - write a signal to a control bus.
	
bus - the index of the bus to write out to. The lowest numbers are written to the audio hardware.
channelsArray - an Array of channels or single output to write out. You cannot change the size of this once a SynthDef has been built.
		
Out adds its output to a given bus, making it available to all nodes later in the node tree. (See Synth and Order-of-execution for more information.) ReplaceOut overwrites those contents. This can make it useful for processing.

See the Server-Architecture and Bus helpfiles for more information on buses and how they are used.
	
	(
	SynthDef("ReplaceOutHelp", { arg out=0, freq=440;
		var source;
			source = SinOsc.ar(freq, 0, 0.1);

			// write to the bus, replacing previous contents
			ReplaceOut.ar(out, source);

	}).send(s);
	)
	
	// each Synth replaces the output of the previous one
	x = Synth.tail(s, "ReplaceOutHelp", [\freq, 500]);
	y = Synth.tail(s, "ReplaceOutHelp", [\freq, 600]);
	z = Synth.tail(s, "ReplaceOutHelp", [\freq, 700]);
	
	// release them in reverse order; the older Synths are still there.
	z.free;
	y.free;
	x.free;


