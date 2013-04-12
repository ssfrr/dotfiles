Median				median filter

Inherits from: Object : AbstractFunction : UGen : Filter 

Median.ar(length, in, mul, add)
Median.kr(length, in, mul, add)


Returns the median of the last length input points. 
This non linear filter is good at reducing impulse noise  from a signal.
length - number of input points in which to find the median. Must be an odd number from 1 to 31.
If length is 1 then Median has no effect.
in - input signal to be processed

// a signal with impulse noise.
{ Saw.ar(500, 0.1) + Dust2.ar(100, 0.9) }.play;

// after applying median filter
{ Median.ar(3, Saw.ar(500, 0.1) + Dust2.ar(100, 0.9)) }.play;

// The median length can be increased for longer duration noise.

// a signal with longer impulse noise.
{ Saw.ar(500, 0.1) + LPZ1.ar(Dust2.ar(100, 0.9)) }.play;

// length 3 doesn't help here because the impulses are 2 samples long.
{ Median.ar(3, Saw.ar(500, 0.1) + LPZ1.ar(Dust2.ar(100, 0.9))) }.play;

// length 5 does better
{ Median.ar(5, Saw.ar(500, 0.1) + LPZ1.ar(Dust2.ar(100, 0.9))) }.play;

// long Median filters begin chopping off the peaks of the waveform
(
{ 
	x = SinOsc.ar(1000, 0, 0.2);
	[x, Median.ar(31, x)]
}.play;
)

// another noise reduction application:

Synth.play({ WhiteNoise.ar(0.1) + SinOsc.ar(800,0,0.1) });

// use Median filter for high frequency noise
Synth.play({ Median.ar(31, WhiteNoise.ar(0.1) + SinOsc.ar(800,0,0.1)) });

(
// use LeakDC for low frequency noise
Synth.play({ 
	LeakDC.ar(Median.ar(31, WhiteNoise.ar(0.1) + SinOsc.ar(800,0,0.1)), 0.9)
});
)


