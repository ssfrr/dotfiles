In				read a signal from a bus

Inherits from: Object : AbstractFunction : UGen : MultiOutUGen : AbstractIn

	*ar(bus, numChannels) - read a signal from an audio bus.
	*kr(bus, numChannels) - read a signal from a control bus.

bus - the index of the bus to read in from.
numChannels - the number of channels (i.e. adjacent buses) to read in. The default is 1. You cannot modulate this number by assigning it to an argument in a SynthDef.

In.kr is functionally similar to InFeedback. That is it reads all data on the bus whether it is from the current cycle or not. This allows for it to receive data from later in the node order. In.ar reads only data from the current cycle, and will zero data from earlier cycles (for use within that synth; the data remains on the bus). Because of this and the fact that the various out ugens mix their output with data from the current cycle but overwrite data from an earlier cycle it may be necessary to use a private control bus when this type of feedback is desired. There is an example below which demonstrates the problem. See the InFeedback and Order-of-execution helpfiles for more details.

Note that using the Bus class to allocate a multichannel bus simply reserves a series of adjacent bus indices with the Server object's bus allocators. abus.index simply returns the first of those indices. When using a Bus with an In or Out ugen there is nothing to stop you from reading to or writing from a larger range, or from hardcoding to a bus that has been allocated. You are responsible for making sure that the number of channels match and that there are no conflicts. See the Server-Architecture and Bus helpfiles for more information on buses and how they are used. 

The hardware input busses begin just after the hardware output busses and can be read from using In.ar. (See  Server-Architecture for more details.) The number of hardware input and output busses can vary depending on your Server's options. For a convienent wrapper class which deals with this issue see SoundIn.

read from an audio bus

	(
	s = Server.local;
	s.boot;
	)
	
	(
	SynthDef("help-PinkNoise", { arg out=0; 
		Out.ar(out, PinkNoise.ar(0.1)) 
	}).send(s);
	
	SynthDef("help-In", { arg out=0, in=0;
		var input;
			input = In.ar(in, 1);
			Out.ar(out, input);

	}).send(s);
	)
	
	//play noise on the right channel
	x = Synth("help-PinkNoise", [\out, 1]);
	 
	//read the input and play it out on the left channel
	Synth.after(x, "help-In", [\out, 0, \in, 1]); 
									

read from a  control bus

	(
	SynthDef("help-InKr",{ arg out=0, in=0;
		Out.ar(out,
			SinOsc.ar(In.kr(in, 1), 0, 0.1)
		)
	}).send(s);
	SynthDef("help-lfo", { arg out=0; 
		Out.kr(out, LFNoise1.kr(0.3, 200, 800)) 
	}).send(s);
	)
	
	
	b = Bus.control(s,1);
	b.set(800);
	
	Synth("help-InKr",[\in, b]); 
	b.set(400);
	b.set(300);
	Synth("help-lfo", [\out, b]);

read control data from a synth later in the node order
	
	(
	SynthDef("help-Infreq", { arg bus;
		Out.ar(0, FSinOsc.ar(In.kr(bus), 0, 0.5));
	}).send(s);
	
	SynthDef("help-Outfreq", { arg freq = 400, bus;
		Out.kr(bus, SinOsc.kr(1, 0, freq/40, freq));
	}).send(s);
	
	b = Bus.control(s,1);
	)
	
	// add the first control Synth at the tail of the default server; no audio yet
	x = Synth.tail(s, "help-Outfreq", [\bus, b]);
	
	// add the sound producing Synth BEFORE it; It receives x's data from the previous cycle
	y = Synth.before(x, "help-Infreq", [\bus, b]);
	
	// add another control Synth before y, at the head of the server
	// It now overwrites x's cycle old data before y receives it
	z = Synth.head(s, "help-Outfreq", [\bus, b, \freq, 800]);
	
	// get another bus
	c = Bus.control(s, 1);
	
	// now y receives x's data even though z is still there
	y.set(\bus, c); x.set(\bus, c);
	
	x.free; y.free; z.free;
	


