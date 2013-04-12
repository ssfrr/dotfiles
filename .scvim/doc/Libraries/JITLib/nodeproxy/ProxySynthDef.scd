ProxySynthDef			synth def that wraps ugen graph


superclass: SynthDef
(used internally by NodeProxy)


*new(name, func, rates, prependArgs, makeFadeEnv, channelOffset=0, chanConstraint)
	name, func,  rates, prependArgs: like in SynthDef
	todo: add variants.
	
	makeFadeEnv
		if true it constructs a fader envelope and adds controls for gate and fadeTime
	channelOffset
		a constant offset that is added to the out number
	chanConstraint
		max numChannels for the synthdef. If ugenfunc returns a larger array, it wraps


*sampleAccurate_
	always use OffsetOut, if set to true (default: false)


for inner workings see jitlib_fading


// example


a = ProxySynthDef("xtest", { SinOsc.ar(400) * 0.1 });

a.send(s);

x = Synth("xtest");
x.release;


/*

	if the resulting number of channels is larger than a given channelConstraint,
	it behaves according to the rate: audio rate signals are wrapped around
	a smaller channel size, control rate signals are not (the exceeding channels are left out)
	
	
*/


