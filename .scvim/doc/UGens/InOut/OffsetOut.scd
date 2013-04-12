OffsetOut			write a signal to a bus with sample accurate timing		

Inherits from: Object : AbstractFunction : UGen : AbstractOut : Out

Output signal to a bus,  the sample offset within the bus is kept exactly; i.e. if the synth is scheduled to be started part way through a control cycle, OffsetOut will maintain the correct offset by buffering the output and delaying it until the exact time that the synth was scheduled for.

This ugen is used where sample accurate output is needed.

*ar(bus, channelsArray)  - write a signal to an audio bus.
*kr(bus, channelsArray)  - write a signal to a control bus.
	
bus - the index, or array of indexes, of busses to write to. The lowest index numbers are written to the audio hardware.
channelsArray - an Array of channels or single output to write out. You cannot change the size of this once a SynthDef has been built.
	
See the Server-Architecture and Bus helpfiles for more information on buses and how they are used.
	
for achieving subsample accuracy see: SubsampleOffset
	
	

// example

	(
	SynthDef("help-OffsetOut", 
		{ arg out=0, freq=440, sustain=0.05;
			var env;
			env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
			OffsetOut.ar(out, SinOsc.ar(freq, 0, env))
	}).send(s);
	
	SynthDef("help-Out", 
		{ arg out=0, freq=440, sustain=0.05;
			var env;
			env = EnvGen.kr(Env.perc(0.01, sustain, 0.2), doneAction:2);
			//compare to Out:
			Out.ar(out, SinOsc.ar(freq, 0, env))
	}).send(s);
	)

	
	// these are in sync
	(
	Routine({
		loop {
			s.sendBundle(0.2, ["/s_new", "help-OffsetOut", -1]);
			0.01.wait;
		}
	}).play;
	)
	
	// these are less reliably in sync and are placed at multiples of blocksize.
	(
	Routine({
		loop {
			s.sendBundle(0.2, ["/s_new", "help-Out", -1]);
			0.01.wait;
		}
	}).play;
	)
	
	
	

Note that if you have an input to the synth, it will be coming in at its normal time, then mixed in your synth, and then delayed with the output. So you shouldn't use OffsetOut for effects or gating.

SynthDef("trig1",{
	var gate,tone;
	gate = Trig1.ar(1.0,t);
	tone = In.ar(10,1); // tone comes in normally
	// but is then delayed when by the OffsetOut
	OffsetOut.ar(0,
		tone * EnvGen.ar(
				Env([0,0.1,0.1,0],[0.01,1.0,0.01],[-4,4],2),
				gate,doneAction: 2
			)
	)
})
	


