Control			ugen that can be set externally

Inherits from: Object : AbstractFunction : UGen : MultiOutUGen

A Control is a UGen that can be set and routed externally to interact with a running Synth.
Typically, Controls are created from the arguments of a SynthDef function.

related subclasses are: TrigControl, LagControl.
For a more concise combination of name, default value and lag, see NamedControl 

The rate may be either .kr (continous control rate signal), .ar (audio rate) or .ir (a static value, set at the time the synth starts up, and subsequently unchangeable).

Control.ar(values)
Control.kr(values)
Control.ir(values)

*names(names) 	adds control names to the SynthDef.

	(
	SynthDef(\help_Control, { | freq = 200 |
		
		freq.inspect; // at the time of compiling the def
	
	}).add
	);
	
	// synonym:
	(
	SynthDef(\help_Control, {
		
		\freq.kr(200).inspect; // at the time of compiling the def
	
	}).add
	);

What is passed into the ugenGraph function is an OutputProxy, and its source is a Control. The main explicit use of Control is to allow Arrays to be sent to running Synths:

	// a synth def that has 4 partials
	(
	SynthDef(\help_Control, { arg out=0, i_freq;
		var klank, harm, amp, ring;
		
		// harmonics
		harm = Control.names([\harm]).ir(Array.series(4, 1, 1).postln);
		// amplitudes
		amp = Control.names([\amp]).ir(Array.fill(4, 0.05));
		// ring times
		ring = Control.names([\ring]).ir(Array.fill(4, 1));
		
		klank = Klank.ar(`[harm, amp, ring], { ClipNoise.ar(0.01) }.dup, i_freq);
		
		Out.ar(out, klank);
	}).add;
	)
	
	a = Synth(\help_Control, [\i_freq, 300, \harm, [1, 3.3, 4.5, 7.8]]);
	a.free;
	a = Synth(\help_Control, [\i_freq, 300, \harm, [2, 3, 4, 5]]);
	a.free;
	
	(
	SynthDef(\help_Control_Sines, { arg out=0;
		var sines, control, numsines;
		numsines = 20;
		control = Control.names(\array).kr(Array.rand(numsines, 400.0, 1000.0));
		sines = Mix(SinOsc.ar(control, 0, numsines.reciprocal)) ;
		Out.ar(out, sines ! 2);
	}).add
	)
	
	b = Synth(\help_Control_Sines);
	b.setn(\array, Array.rand(20, 200, 1600));
	b.setn(\array, Array.rand(20, 200, 1600));
	
	
	
	(
	SynthDef(\help_Control_DynKlank, { arg out=0, freq = 440;
		var klank, harm, amp, ring;
		
		// harmonics
		harm = Control.names(\harm).kr(Array.series(4, 1, 1));
		// amplitudes
		amp = Control.names(\amp).kr(Array.fill(4, 0.05));
		// ring times
		ring = Control.names(\ring).kr(Array.fill(4, 1));
		klank = DynKlank.ar(`[harm, amp, ring], {ClipNoise.ar(0.003)}.dup, freq);
		Out.ar(out, klank);
	}).add
	)
	
	a = Synth(\help_Control_DynKlank, [\freq, 300]);
	b = Synth(\help_Control_DynKlank, [\freq, 400]);
	
	
	a.setn(\harm,   Array.rand(4, 1.0, 4.7))
	a.setn(\amp, Array.rand(4, 0.005, 0.1))
	a.setn(\ring, Array.rand(4, 0.005, 1.0))
	
	b.setn(\harm,   Array.rand(4, 1.0, 4.7))
	b.setn(\amp, Array.rand(4, 0.005, 0.1))
	b.setn(\ring, Array.rand(4, 0.005, 1.0))



Symbols

	Inside SynthDefs and UGen functions, symbols can be used to conventiently specify control inputs of different rates and with lags (see: ControlName, and Symbol)
	
	
	kr(val, lag)
	
	Return a control rate NamedControl input with a default value (val), and if supplied, with a lag. If val is an array, the control will be multichannel.
	
	a = { SinOsc.ar(\freq.kr(440, 1.2)) }.play;
	a.set(\freq, 330);
	a.release;
	a = { SinOsc.ar(\freq.kr([440, 460], 1.2)) }.play;
	a.setn(\freq, [330, 367]);
	a.release;
	
	ar(val, lag)
	
	Return an audio rate NamedControl input with a default value (val), and if supplied, with a lag. If val is an array, the control will be multichannel.

	ir(val)
	
	Return an intitalization rate NamedControl input with a default value (val). If val is an array, the control will be multichannel.
		
	tr(val)
	
	Return a TrigControl input with a default value (val). If val is an array, the control will be multichannel.
	
	a = { Ringz.ar(T2A.ar(\trig.tr), \freq.kr(500, 1), 0.8) }.play;
	a.set(\freq, 330, \trig, 1);
	a.set(\freq, 830, \trig, 1);
	a.release;
	
	




