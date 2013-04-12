Lag			exponential lag

Lag.ar(in, lagTime, mul, add)
Lag.kr(in, lagTime, mul, add)

This is essentially the same as OnePole except that instead of supplying the coefficient directly, it is calculated from a 60 dB lag time. This is the time required for the filter to converge to within 0.01 % of a value. This is useful for smoothing out control signals.

in - input signal
lagTime - 60 dB lag time in seconds. 

See also LagUD, Ramp

(
// used to lag pitch
{
	SinOsc.ar(		// sine wave
		Lag.kr(			// lag the modulator
			LFPulse.kr(4, 0, 0.5, 50, 400),	// frequency modulator
			Line.kr(0, 1, 15)				// modulate lag time
		), 
		0,	// phase
		0.3	// sine amplitude
	) 
}.play
)


