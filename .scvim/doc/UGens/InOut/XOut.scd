XOut			send signal to a bus, crossfading with previous contents

Inherits from: Object : AbstractFunction : UGen : AbstractOut

*ar(bus, xfade, channelsArray) - crossfade an audio bus.
*kr(bus, xfade, channelsArray) - crossfade an control bus.
	
bus - the index, or array of indexes, of busses to write to. The lowest index numbers are written to the audio hardware.
xfade - crossfade level.
channelsArray - an Array of channels or single output to write out. You cannot change the size of this once a SynthDef has been built.

xfade is a level for the crossfade between what is on the bus and what you are sending.
The algorithm is equivalent to this:

bus_signal = (input_signal * xfade) + (bus_signal * (1 - xfade));

See the Server-Architecture and Bus helpfiles for more information on buses and how they are used.	
	
	(
	SynthDef("help-SinOsc", { arg freq=440, out; 
		Out.ar(out, SinOsc.ar(freq, 0, 0.1)) 
	}).send(s);
	
	SynthDef("help-XOut", { arg out=0, xFade=1;
		var source;
			source = PinkNoise.ar(0.05);

			// write to the bus, crossfading with previous contents
			XOut.ar(out, xFade, source);

	}).send(s);
	)
	
	Synth("help-SinOsc", [\freq, 500]);
	a = Synth.tail(s, "help-XOut");
	
	
	a.set(\xFade, 0.7);
	a.set(\xFade, 0.4);
	a.set(\xFade, 0.0);
	
	


