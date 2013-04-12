Slew			slew rate limiter

Inherits from: Object : AbstractFunction : UGen : Filter 


Slew.ar(in, upSlope, downSlope, mul, add)
Slew.kr(in, upSlope, downSlope, mul, add)


Limits the slope of an input signal. The slope is expressed in units per second.
in - input signal.
upSlope - maximum upward slope.
downSlope - maximum downward slope.


(
{
	z = LFPulse.ar(800);
	[z, Slew.ar(z, 4000, 4000)]
}.plot)


// Has the effect of removing transients and higher frequencies.
(
{

	z = Saw.ar(800, 0.2);
	Slew.ar(z, 400, 400)
}.play
)





