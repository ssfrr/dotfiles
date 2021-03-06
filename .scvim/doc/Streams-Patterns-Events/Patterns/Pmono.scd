Pmono			monophonic event stream

Superclass: Pattern

Pmono(synthDefName, patternPairs)

Plays one instance of a Synth.  The pattern pairs define changes in that one synth's controls. This node is created when entering a Pmono, and released when the Pmono terminates. There is just one node for the duration of the entire pattern, and it will sustain through each event. If a monophonic phrase requires staccato notes or re-articulation between some notes, see PmonoArtic.

If event[\id] is not nil, Pmono simply directs its pattern changes to that node and does not create an extra synth.


Examples

p = Pmono(\default, \dur, 0.2, \freq, Pwhite(1,8) * 100 ).play

p.stop

// multi channel expansion is supported:
p = Pmono(\default, \dur, 0.2, \freq, Pwhite(1,8) * 100, \detune, [0,2,5,1]).play

p.stop


// the following example will end after 5 seconds
// or you can stop it sooner with a stop message
(
	p = Pfindur(5,
		Pset(\detune,Pwhite(0,1.0) * [0,1,3,7],
			Ppar([
				Pmono(\default, \dur, 0.2, \freq, Pwhite(1,8) * 100 ),
				Pmono(\default, \dur, 0.1, \freq, Pwhite(1,8) * 300)
			])
		)
	).play;
)
p.stop;


Note:
A related approach is to instantiate a Synth yourself and then set its values by using an Event whose "type" is \set, as illustrated here. The user is responsible for ensuring proper synchronization between between Synth creation and pattern execution.

// First we create something to control
x = {|freq=440, amp=0.6| MoogFF.ar(PinkNoise.ar(amp), freq).dup}.play;

// In the following pattern, the first two keys are the ones that create the monophonic behaviour:
(
p = Pbind(
	\type, \set,	// This tells it we'll be setting parameters of an existing node...
	\id, x.nodeID,	// ...and this tells it whose parameters we'll be setting
	\freq, Pwhite(100, 1000),
	\dur, 0.2,
	\amp, Pseq((1,0.99 .. 0.1), inf)
).play;
)

p.stop
x.free


SynthDef variant support

SynthDefs allow alternate sets of default values to be defined (see "Variants" in SynthDef help). Most event patterns, such as Pbind, specify the variant using the variant key in the output events. (Note that variants are always optional.) In Pmono, the mechanism is different because the the SynthDef name, including variant suffix, must be known before evaluating the first event. So, the variant suffix is provided in the first Pmono argument:

Pmono('synthDefName.variant', pairs...)


