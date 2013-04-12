GrainSin			Granular synthesis with sine tones

GrainSin.ar(numChannels, trigger, dur, freq, pan, envbufnum, maxGrains, mul, add)

	numChannels - the number of channels to output. If 1, mono is returned and pan is ignored.
	trigger - a kr or ar trigger to start a new grain. If ar, grains after the start of the synth are sample accurate.
	The following args are polled at grain creation time
	dur - size of the grain.
	freq - the input to granulate
	pan -  Determines where to pan the output. If numChannels = 1, no panning is done. 
		If numChannels = 2, panning is similar to Pan2.
		if numChannels > 2, pannins is the same as PanAz.	
	envbufnum - the buffer number containing a singal to use for the grain envelope. -1 uses a built-in 
		Hanning envelope.
	maxGrains - the maximum number of overlapping grains that can be used at a given time. This value
		is set at the UGens init time and can't be modified. Defaults to 512. This can be set lower for more
		efficient use of memory.
	*WARNING* The above parameter is new (post SC 3.3.1) and has the potential to break code written
		<= 3.3.1. This parameter is BEFORE the mul slot, and you may need to update code to account
		for this difference.


Examples:

s.boot;

(
var winenv;
// a custom envelope 
winenv = Env([0, 1, 0], [0.5, 0.5], [8, -8]);
z = Buffer.sendCollection(s, winenv.discretize, 1);

SynthDef(\sin_grain_test, {arg gate = 1, amp = 1, envbuf;
	var pan, env, freqdev;
	// use mouse x to control panning
	pan = MouseX.kr(-1, 1);
	// use WhiteNoise and mouse y to control deviation from center pitch
	freqdev = WhiteNoise.kr(MouseY.kr(0, 400));
	env = EnvGen.kr(
		Env([0, 1, 0], [1, 1], \sin, 1),
		gate,
		levelScale: amp,
		doneAction: 2);
	Out.ar(0,
		GrainSin.ar(2, Impulse.kr(10), 0.1, 440 + freqdev, pan, envbuf) * env)
	}).send(s);

)
s.scope
// use built-in env
x = Synth(\sin_grain_test, [\envbuf, -1])

// switch to the custom env
x.set(\envbuf, z)
x.set(\envbuf, -1);

x.set(\gate, 0);
  


