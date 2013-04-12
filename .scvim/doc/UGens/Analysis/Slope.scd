Slope		slope of signal

Slope.ar(in, mul, add)
Slope.kr(in, mul, add)

Measures the rate of change per second of a signal.
Formula implemented is:

out[i] = (in[i] - in[i-1]) * sampling_rate

in - input signal to measure.

(
{
	var a, b, c, scale;
	a = LFNoise2.ar(2000);	// quadratic noise
	b = Slope.ar(a);		// first derivative produces line segments
	c = Slope.ar(b);		// second derivative produces constant segments
	scale = 0.0002;	// needed to scale back to +/- 1.0
	[a, b * scale, c * scale.squared]
}.plot
)

For another example of Slope see [hypot].


