Pluck			a Karplus-Strong UGen

Pluck.ar(in, trig, maxdelaytime, delaytime, decaytime, coef, mul, add)

in - an excitation signal
trig - upon a negative to positive transition, the excitation signal will be fed into the delay line
maxdelaytime - the max delay time in seconds (initializes the internal delay buffer).
delaytime - delay time in seconds.
decaytime - time for the echoes to decay by 60 decibels. Negative times emphasize odd partials.
coef - the coef of the internal OnePole filter. Values should be between -1 and +1 (larger values will
	be unstable... so be careful!).

s.boot;

// excitation signal is WhiteNoise, triggered twice a second with varying OnePole coef
(
	{Pluck.ar(WhiteNoise.ar(0.1), Impulse.kr(2), 440.reciprocal, 440.reciprocal, 10, 
		coef:MouseX.kr(-0.999, 0.999))
	}.play(s)
)
s.quit;
// a group of angry fretless mandolin players
(
	{
		var freq, numparts;
		numparts = 50;
		freq = SinOsc.kr(Array.fill(numparts, {Rand(0.05, 0.2)}), 
			Array.fill(numparts, {Rand(0, 1.0)})).range(1000, 3000);
		LeakDC.ar(
			Pan2.ar(
				Pluck.ar(
					WhiteNoise.ar(0.1).dup(numparts), 
					Impulse.kr(Array.fill(numparts, {Rand(10, 12)})), 
					100.reciprocal, freq.reciprocal, 2, Rand(0.01, 0.2), mul: 1),
				Array.fill(numparts, {Rand.new(-1.0, 1.0)}))
			.sum
			);
		}.play(s);
)




