LocalIn				define and read from buses local to a synth

Inherits from: Object : AbstractFunction : UGen : MultiOutUGen : AbstractIn

*ar(numChannels) - define and read from an audio bus local to the enclosing synth.
*kr(numChannels) - define and read from a control bus local to the enclosing synth.

numChannels - the number of channels (i.e. adjacent buses) to read in. The default is 1. You cannot modulate this number by assigning it to an argument in a SynthDef.

LocalIn defines buses that are local to the enclosing synth. These are like the global buses, but are more convenient if you want to implement a self contained effect that uses a feedback processing loop.
There can only be one audio rate and one control rate LocalIn per SynthDef.
The audio can be written to the bus using LocalOut.

N.B. Audio written to a LocalOut will not be read by a corresponding LocalIn until the next cycle, i.e. one block size of samples later. Because of this it is important to take this additional delay into account when using LocalIn to create feedback delays with delay times shorter than the threshold of pitch (i.e. < 0.05 seconds or > 20Hz), or where sample accurate alignment is required. See the resonator example below.

(
{
	var source, local;
	
	source = Decay.ar(Impulse.ar(0.3), 0.1) * WhiteNoise.ar(0.2);
	
	local = LocalIn.ar(2) + [source, 0]; // read feedback, add to source
	
	local = DelayN.ar(local, 0.2, 0.2); // delay sound
	
	// reverse channels to give ping pong effect, apply decay factor
	LocalOut.ar(local.reverse * 0.8); 
	
	Out.ar(0, local);
}.play;
)



(
z = SynthDef("tank", {
	var local, in;
	
	in = Mix.fill(12, { 
		Pan2.ar(
			Decay2.ar(Dust.ar(0.05), 0.1, 0.5, 0.1) 
				* FSinOsc.ar(IRand(36,84).midicps).cubed.max(0), 
			Rand(-1,1))
	});
	in = in + Pan2.ar(Decay2.ar(Dust.ar(0.03), 0.04, 0.3) * BrownNoise.ar, 0);
	
	4.do { in = AllpassN.ar(in, 0.03, {Rand(0.005,0.02)}.dup, 1); };
	
	local = LocalIn.ar(2) * 0.98;
	local = OnePole.ar(local, 0.5);
	
	local = Rotate2.ar(local[0], local[1], 0.23);
	local = AllpassN.ar(local, 0.05, {Rand(0.01,0.05)}.dup, 2);
	 			
	local = DelayN.ar(local, 0.3, [0.19,0.26]);
	local = AllpassN.ar(local, 0.05, {Rand(0.03,0.15)}.dup, 2);
	
	local = LeakDC.ar(local);	
	local = local + in;
		
	LocalOut.ar(local);
	
	Out.ar(0, local);
}).play;
)



(
z = SynthDef("tape", {
	var local, in, amp;
	
	in = SoundIn.ar([0,1]);
	
	amp = Amplitude.kr(Mix.ar(in));
	in = in * (amp > 0.02); // noise gate
	
	local = LocalIn.ar(2);
	local = OnePole.ar(local, 0.4);
	local = OnePole.ar(local, -0.08);
	
	local = Rotate2.ar(local[0], local[1], 0.2);
	 			
	local = DelayN.ar(local, 0.25, 0.25);
	
	local = LeakDC.ar(local);	
	local = ((local + in) * 1.25).softclip;
		
	LocalOut.ar(local);
	
	Out.ar(0, local * 0.1);
}).play;
)

// Resonator, must subtract blockSize for correct tuning
(
var play, imp, initial;
SynthDef("testRes", {

play = LocalIn.ar(1); 
imp = Impulse.ar(1);

LocalOut.ar(DelayC.ar(imp + (play * 0.995), 1, 440.reciprocal - ControlRate.ir.reciprocal)); // for feedback

OffsetOut.ar(0, play);

}).play(s);

{SinOsc.ar(440, 0, 0.2) }.play(s, 1); // compare pitch
)

