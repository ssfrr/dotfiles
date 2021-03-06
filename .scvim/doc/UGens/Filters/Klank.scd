Klank			bank of resonators

Klank.ar(specificationsArrayRef, input, freqscale, freqoffset, decayscale)

Klank is a bank of fixed frequency resonators which can be used to simulate the resonant modes of an object. Each mode is given a ring time, which is the time for the mode to decay by 60 dB.

The parameters in specificationsArrayRef can't be changed after it has been started. 
For a modulatable but less efficient version, see DynKlank.

specificationsArrayRef - a Ref to an Array of three Arrays :
	frequencies - an Array of filter frequencies.
	amplitudes - an Array of filter amplitudes, or nil. If nil, then amplitudes default to 1.0
	ring times - an Array of 60 dB decay times for the filters.
All subarrays, if not nil, should have the same length.
input - the excitation input to the resonant filter bank.
freqscale - a scale factor multiplied by all frequencies at initialization time.
freqoffset - an offset added to all frequencies at initialization time.
decayscale - a scale factor multiplied by all ring times at initialization time.

{ Klank.ar(`[[800, 1071, 1153, 1723], nil, [1, 1, 1, 1]], Impulse.ar(2, 0, 0.1)) }.play;

{ Klank.ar(`[[800, 1071, 1353, 1723], nil, [1, 1, 1, 1]], Dust.ar(8, 0.1)) }.play;

{ Klank.ar(`[[800, 1071, 1353, 1723], nil, [1, 1, 1, 1]], PinkNoise.ar(0.007)) }.play;

{ Klank.ar(`[[200, 671, 1153, 1723], nil, [1, 1, 1, 1]], PinkNoise.ar([0.007,0.007])) }.play;

(
play({
	Klank.ar(`[ 
		Array.rand(12, 800.0, 4000.0),		// frequencies
		nil,  							// amplitudes (default to 1.0)
		Array.rand(12, 0.1, 2)				// ring times
		], Decay.ar(Impulse.ar(4), 0.03, ClipNoise.ar(0.01)))
})
)



// a synth def that has 4 partials
(
s = Server.local;
SynthDef("help-Control", { arg out=0,i_freq;
	var klank, n, harm, amp, ring;
	
	// harmonics
	harm = Control.names([\harm]).ir(Array.series(4,1,1).postln);
	// amplitudes
	amp = Control.names([\amp]).ir(Array.fill(4,0.05));
	// ring times
	ring = Control.names([\ring]).ir(Array.fill(4,1));
	
	klank = Klank.ar(`[harm,amp,ring], {ClipNoise.ar(0.003)}.dup, i_freq);
	
	Out.ar(out, klank);
}).send(s);
)

// nothing special yet, just using the default set of harmonics.
a = Synth("help-Control",[\i_freq, 300]);
b = Synth("help-Control",[\i_freq, 400]);
c = Synth("help-Control",[\i_freq, 533.33]);
d = Synth("help-Control",[\i_freq, 711.11]);

a.free;
b.free;
c.free;
d.free;

// in order to set the harmonics amps and ring times at
// initialization time we need to use an OSC bundle.
(
s.sendBundle(nil,
	["/s_new", "help-Control", 2000, 1, 0, \i_freq, 500], // start note
	["/n_setn", 2000, "harm", 4, 1, 3, 5, 7] // set odd harmonics
	);
)

s.sendMsg("/n_free", 2000);

(
s.sendBundle(nil,
	["/s_new", "help-Control", 2000, 1, 0, \i_freq, 500], // start note
	// set geometric series harmonics
	["/n_setn", 2000, "harm", 4] ++ Array.geom(4,1,1.61)
	);
)

s.sendMsg("/n_free", 2000);

(
// set harmonics, ring times and amplitudes
s.sendBundle(nil,
	["/s_new", "help-Control", 2000, 1, 0, \i_freq, 500], // start note
	["/n_setn", 2000, "harm", 4, 1, 3, 5, 7], // set odd harmonics
	["/n_setn", 2000, "ring", 4] ++ Array.fill(4,0.1), // set shorter ring time
	["/n_setn", 2000, "amp", 4] ++ Array.fill(4,0.2) // set louder amps
	);
)

s.sendMsg(\n_trace, 2000);
s.sendMsg("/n_free", 2000);

(
// same effect as above, but packed into one n_setn command
s.sendBundle(nil,
	["/s_new", "help-Control", 2000, 1, 0, \i_freq, 500], // start note
	["/n_setn", 2000, "harm", 4, 1, 3, 5, 7,
		"ring", 4] ++ Array.fill(4,0.1)
		++ ["amp", 4] ++ Array.fill(4,0.2)
	);
)

s.sendMsg("/n_free", 2000);




//////////////////////////////////////////////////////////////////////

//-- overlap texture
(
SynthDef("help-KlankOverlapTexture", {|out = 0, freqs = #[0,0,0,0,0,0,0,0,0,0,0,0], rings = #[0,0,0,0,0,0,0,0,0,0,0,0], atk = 5, sus = 8, rel = 5, pan = 0|
	var e = EnvGen.kr(Env.linen(atk, sus, rel, 1, 4), doneAction:2);
	var i = Decay.ar(Impulse.ar(Rand(0.8, 2.2)), 0.03, ClipNoise.ar(0.01));
	var z = Klank.ar(
		`[freqs, nil, rings],	// specs
		i					// input
	);
	Out.ar(out, Pan2.ar(z*e, pan));
}).send(s);

r = Routine{
	var sustain = 8, transition = 3, overlap = 4;
	var period = transition*2+sustain/overlap;
	0.5.wait;			//wait for the synthdef to be sent to the server
	inf.do{
		Synth("help-KlankOverlapTexture", [
			\atk, transition,
			\sus, sustain,
			\rel, transition,
			\pan, 1.0.rand2
		]).setn(
			\freqs, {200.0.rrand(4000)}.dup(12),
			\rings, {0.1.rrand(2)}.dup(12)
		);
		period.wait;
	}
};
r.play;
)

r.stop;	//stop spawning new synths



//-- frequency and decay scaling
(
SynthDef("help-KlankScaling", {|out = 0, freq = 0, rings = #[0,0,0,0,0,0,0,0,0,0,0,0], pan = 0|
	var e = EnvGen.kr(Env(#[1, 1, 0], #[0.4, 0.01]), doneAction:2);
	var i = Decay.ar(Impulse.ar(0), 0.03, ClipNoise.ar(0.01));
	var z = Klank.ar(
		`[(1..12), nil, rings],				// specs (partials, amplitudes, ringtimes)
		i,								// input
		freq,							// scale to this frequency
		0,								// frequency offset
		MouseX.kr(0.2, 3)					// scale decay times
	);
	Out.ar(out, Pan2.ar(z*e, pan));
}).send(s);

r = Routine{
	var sustain = 8, transition = 3;
	var mode = #[0, 2, 4, 5, 7, 9, 11, 12, 14, 16, 17, 19, 21, 23, 24];
	0.5.wait;			//wait for the synthdef to be sent to the server
	inf.do{|i|
		Synth("help-KlankScaling", [
			\freq, (72 + (mode @@ i)).midicps
		]).setn(\rings, {0.1.rrand(2)}.dup(12));
		0.2.wait;
	}
};
r.play;
)

r.stop;


//-- overlap texture 2
(
SynthDef("help-KlankOverlapTexture2", {|out = 0, freqs = #[0,0,0,0,0,0,0,0,0,0,0,0], rings = #[0,0,0,0,0,0,0,0,0,0,0,0], atk = 5, sus = 8, rel = 5, pan = 0|
	var e = EnvGen.kr(Env.linen(atk, sus, rel, 1, 4), doneAction:2);
	var i = BrownNoise.ar(0.0012);
	var z = Klank.ar(
		`[freqs, nil, rings],	// specs
		i					// input
	);
	Out.ar(out, Pan2.ar(z*e, pan));
}).send(s);

r = Routine{
	var sustain = 6, transition = 4, overlap = 5;
	var period = transition*2+sustain/overlap;
	0.5.wait;			//wait for the synthdef to be sent to the server
	inf.do{
		Synth("help-KlankOverlapTexture2", [
			\atk, transition,
			\sus, sustain,
			\rel, transition,
			\pan, 1.0.rand2
		]).setn(
			\freqs, {6000.0.linrand+80}.dup(12),
			\rings, {0.1.rrand(3)}.dup(12)
		);
		period.wait;
	}
};
r.play;
)

r.stop;


//-- overlap texture 3
(
SynthDef("help-KlankOverlapTexture3", {|out = 0, freqs = #[0,0,0,0,0,0,0,0,0,0,0,0], rings = #[0,0,0,0,0,0,0,0,0,0,0,0], pan = 0|
	var e = EnvGen.kr(Env(#[1, 1, 0], #[18, 3]), doneAction:2);
	var i = Decay.ar(Impulse.ar(Rand(0.2, 0.6)), 0.8, ClipNoise.ar(0.001));
	var z = Klank.ar(
		`[freqs, 2, rings],	// specs
		i					// input
	);
	Out.ar(out, Pan2.ar(z*e, pan));
}).send(s);

r = Routine{
	0.5.wait;			//wait for the synthdef to be sent to the server
	inf.do{
		Synth("help-KlankOverlapTexture3", [
			\pan, 1.0.rand2
		]).setn(
			\freqs, {12000.0.linrand+80}.dup(12),
			\rings, {3.rrand(10)}.dup(12)
		);
		3.wait;
	}
};
r.play;
)

r.stop;



