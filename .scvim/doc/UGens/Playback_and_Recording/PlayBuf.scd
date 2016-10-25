PlayBuf		sample playback oscillator

Inherits from: Object : AbstractFunction : UGen

Plays back a sample resident in memory.

PlayBuf.ar(numChannels, bufnum, rate, trigger, startPos, loop, doneAction)
PlayBuf.kr(numChannels, bufnum, rate, trigger, startPos, loop, doneAction)

	numChannels - number of channels that the buffer will be.
			this must be a fixed integer. The architecture of the SynthDef
			cannot change after it is compiled.
			warning: if you supply a bufnum of a buffer that has a different
			numChannels then you have specified to the PlayBuf, it will
			fail silently.
	bufnum - the index of the buffer to use
	rate  - 1.0 is the server's sample rate, 2.0 is one octave up, 0.5 is one octave down
			-1.0 is backwards normal rate ... etc. Interpolation is cubic.
		Note: If the buffer's sample rate is different from the server's, you will need to
			multiply the desired playback rate by (file's rate / server's rate). The UGen
			BufRateScale.kr(bufnum) returns this factor. See examples below.
			BufRateScale should be used in virtually every case.
	trigger - a trigger causes a jump to the startPos. 
		A trigger occurs when a signal changes from <= 0 to > 0.
	startPos - sample frame to start playback.
	loop    - 1 means true, 0 means false. this is modulate-able.
	doneAction - an integer representing an action to be executed when the buffer is finished playing. This can be used to free the enclosing synth, etc. See UGen-doneActions for more detail.

See also: DiskIn, BufRd



s.boot // Boot the server, if you need to 

// read a whole sound into memory
// note: not *that* columbia, the first one
b = Buffer.read(s, "sounds/a11wlk01.wav"); // remember to free the buffer later.

SynthDef(\help_PlayBuf, {| out = 0, bufnum = 0 |
	Out.ar(out, 
		PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction:2)
	)
}).play(s, [\out, 0, \bufnum, b]);

In the above example, note how the doneAction:2 causes the synth to free itself when the buffer reaches its end.

Note again that the number of channels must be fixed for the SynthDef. It cannot vary depending on which buffer you use.


// loop is true
SynthDef(\help_PlayBuf, {| out = 0, bufnum = 0 |
	Out.ar(out, 
		PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), loop: 1.0)
	)
}).play(s, [\out, 0, \bufnum, b]);



// trigger one shot on each pulse
SynthDef(\help_PlayBuf, {| out = 0, bufnum = 0 |
	var trig;
	trig = Impulse.kr(2.0);
	Out.ar(out, 
		PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), trig, 0, 0)
	)
}).play(s, [\out, 0, \bufnum, b]);


// trigger one shot on each pulse
SynthDef(\help_PlayBuf, {| out = 0, bufnum = 0 |
	var trig;
	trig = Impulse.kr(XLine.kr(0.1, 100, 30));
	Out.ar(out, 
		PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), trig, 5000, 0)
	)
}).play(s, [\out, 0, \bufnum, b]);




// mouse control of trigger rate and startpos
SynthDef(\help_PlayBuf, { arg out=0, bufnum=0;
	var trig;
	trig = Impulse.kr(MouseY.kr(0.5, 200, 1));
	Out.ar(out, 
		PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), trig, MouseX.kr(0, BufFrames.kr(bufnum)), 1)
	)
}).play(s, [\out, 0, \bufnum, b]);



// accelerating pitch
SynthDef(\help_PlayBuf, {| out = 0, bufnum = 0 |
	var rate;
	rate = XLine.kr(0.1, 100, 60);
	Out.ar(out, 
		PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)*rate, 1.0, 0.0, 1.0)
	)
}).play(s, [\out, 0, \bufnum, b]);



// sine wave control of playback rate. negative rate plays backwards
SynthDef(\help_PlayBuf, {| out = 0, bufnum = 0 |
	var rate;
	rate = FSinOsc.kr(XLine.kr(0.2, 8, 30), 0, 3, 0.6);
	Out.ar(out, 
		PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * rate, 1, 0, 1)
	)
}).play(s, [\out, 0, \bufnum, b]);


// zig zag around sound 
SynthDef(\help_PlayBuf, {| out = 0, bufnum = 0 |
	var rate;
	rate = LFNoise2.kr(XLine.kr(1, 20, 60), 2);
	Out.ar(out, 
		PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum) * rate, 1, 0, 1)
	)
}).play(s, [\out, 0, \bufnum, b]);


b.free;


