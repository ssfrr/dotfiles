InFeedback		read signal from a bus with a current or one cycle old timestamp

Inherits from: Object : AbstractFunction : UGen : MultiOutUGen : AbstractIn
	
*ar(bus, numChannels)
	
bus - the index of the bus to read in from.
numChannels - the number of channels (i.e. adjacent buses) to read in. The default is 1. You cannot modulate this number by assigning it to an argument in a SynthDef.

When the various output ugens (Out, OffsetOut, XOut) write data to a bus, they mix it with any data from the current cycle, but overwrite any data from the previous cycle. (ReplaceOut overwrites all data regardless.) Thus depending on node order and what synths are writing to the bus, the data on a given bus may be from the current cycle or be one cycle old at the time of reading. In.ar checks the timestamp of any data it reads in and zeros any data from the previous cycle (for use within that node; the data remains on the bus). This is fine for audio data, as it avoids feedback, but for control data it is useful to be able to read data from any place in the node order. For this reason In.kr also reads data that is older than the current cycle.

In some cases we might also want to read audio from a node later in the current node order. This is the purpose of InFeedback. The delay introduced by this is one block size, which equals about 0.0014 sec at the default block size and sample rate. (See the resonator example below to see the implications of this.)

The variably mixing and overwriting behaviour of the output ugens can make order of execution crucial. (No pun intended.) For example with a node order like the following the InFeedback ugen in Synth 2 will only receive data from Synth 1 (-> = write out; <- = read in):

Synth 1 -> busA					this synth overwrites the output of Synth3 before it reaches Synth 2
Synth 2 (with InFeedback) <- busA 
Synth 3 -> busA

If Synth 1 were moved after Synth 2 then Synth 2's InFeedback would receive a mix of the output from Synth 1 and Synth 3. This would also be true if Synth 2 came after Synth1 and Synth 3. In both cases data from Synth 1 and Synth 3 would have the same time stamp (either current or from the previous cycle), so nothing would be overwritten.

Because of this it is often useful to allocate a separate bus for feedback. With the following arrangement Synth 2 will receive data from Synth3 regardless of Synth 1's position in the node order.

Synth 1 -> busA
Synth 2 (with InFeedback) <- busB 
Synth 3 -> busB + busA 

The second example below demonstrates this issue.

See also LocalIn and LocalOut.


Examples

audio feedback modulation:

	(
	SynthDef(\help_InFeedback, { arg out=0, in=0;
		var input, sound;
			input = InFeedback.ar(in, 1);
			sound = SinOsc.ar(input * 1300 + 300, 0, 0.4);
			Out.ar(out, sound);

	}).play;
	)

this shows how a node can read audio from a bus that is being written to by a synth following it:

	(
	SynthDef(\help_InFeedback, { arg out=0, in=0;
		Out.ar(out,
			InFeedback.ar(in, 1)
		);
	}).send(s);
	SynthDef(\help_SinOsc, { arg out=0, freq=440;
		Out.ar(out, SinOsc.ar(freq, 0, 0.1))
	}).send(s);
	)
	
	x = Bus.audio(s, 1);

	// read from bus n play to bus 0 (silent)
	a = Synth(\help_InFeedback,[\in, x, \out, 0]);

	// now play a synth after this one, playing to bus x
	b = Synth.after(a, \help_SinOsc, [\out, x]);
	
	// add another synth before a which also writes to bus x
	// now you can't hear b, as its data is one cycle old, and is overwritten by c
	c = Synth.before(a, \help_SinOsc, [\out, x, \freq, 800]);
	
	// free c and you can hear b again
	c.free;
	x.free;
	
	a.free; b.free;

The example below implements a resonator. Note that you must subtract the blockSize in order for the tuning to be correct. See LocalIn for an equivalent example.
	
	(
	var play, imp, initial;
	SynthDef("testRes", {
	
	play = InFeedback.ar(10, 1); // 10 is feedback channel
	imp = Impulse.ar(1);
	
	// feedback
	OffsetOut.ar(10, DelayC.ar(imp + (play * 0.995), 1, 
		440.reciprocal - ControlRate.ir.reciprocal)); // subtract block size
	
	OffsetOut.ar(0, play);
	
	}).play(s);
	
	// Compare with this for tuning
	{ SinOsc.ar(440, 0, 0.2) }.play(s, 1);
	)
		


