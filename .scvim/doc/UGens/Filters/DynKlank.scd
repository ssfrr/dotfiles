DynKlank			dynamic bank of resonators

DynKlank.ar(specificationsArrayRef, input, freqscale, freqoffset, decayscale)
DynKlank.kr(specificationsArrayRef, input, freqscale, freqoffset, decayscale)

DynKlank is a bank of resonators which can be used to simulate the resonant modes of an object. Each mode is given a ring time, which is the time for the mode to decay by 60 dB.

Unlike Klank, the parameters in specificationsArrayRef can be changed after it has been started.

specificationsArrayRef - a Ref to an Array of three Arrays :
	frequencies - an Array of filter frequencies.
	amplitudes - an Array of filter amplitudes, or nil. If nil, then amplitudes default to 1.0
	ring times - an Array of 60 dB decay times for the filters.
All subarrays, if not nil, should have the same length.
input - the excitation input to the resonant filter bank.
freqscale - a scale factor multiplied by all frequencies at initialization time.
freqoffset - an offset added to all frequencies at initialization time.
decayscale - a scale factor multiplied by all ring times at initialization time.

s.boot;

{ DynKlank.ar(`[[800, 1071, 1153, 1723], nil, [1, 1, 1, 1]], Impulse.ar(2, 0, 0.1)) }.play;

{ DynKlank.ar(`[[800, 1071, 1353, 1723], nil, [1, 1, 1, 1]], Dust.ar(8, 0.1)) }.play;

{ DynKlank.ar(`[[800, 1071, 1353, 1723], nil, [1, 1, 1, 1]], PinkNoise.ar(0.007)) }.play;

{ DynKlank.ar(`[[200, 671, 1153, 1723], nil, [1, 1, 1, 1]], PinkNoise.ar([0.007,0.007])) }.play;


(
// change freqs and ringtimes with mouse
{	var freqs, ringtimes;
	freqs = [800, 1071, 1153, 1723] * MouseX.kr(0.5, 2, 1);
	ringtimes = [1, 1, 1, 1] * MouseY.kr(0.1, 10, 1);
	DynKlank.ar(`[freqs, nil, ringtimes ], Impulse.ar(2, 0, 0.1))
}.play;
)

(
// set them from outside later:
SynthDef('help-dynKlank', {
	var freqs, ringtimes, signal;
	freqs = Control.names([\freqs]).kr([800, 1071, 1153, 1723]);
	ringtimes = Control.names([\ringtimes]).kr([1, 1, 1, 1]);
	signal = DynKlank.ar(`[freqs, nil, ringtimes ], Impulse.ar(2, 0, 0.1));
	Out.ar(0, signal);
}).add;
)

a = Synth('help-dynKlank');

a.setn(\freqs, Array.rand(4, 500, 2000));
a.setn(\ringtimes, Array.rand(4, 0.2, 4) );

// create multichannel controls directly with literal arrays:
(
SynthDef('help-dynKlank', {| 
	freqs (#[100, 200, 300, 400]), 
	amps (#[1, 0.3, 0.2, 0.05]), 
	rings (#[1, 1, 1, 2])|

	Out.ar(0, DynKlank.ar(`[freqs, amps, rings], WhiteNoise.ar * 0.001))
}).add
)

a = Synth('help-dynKlank');

a.setn(\freqs, Array.rand(4, 500, 2000));
a.setn(\amps, Array.exprand(4, 0.01, 1));

{ Out.kr(102, MouseX.kr(1, 2) * Array.rand(4, 500, 2000)) }.play;
a.mapn(\freqs, 102, 4);


