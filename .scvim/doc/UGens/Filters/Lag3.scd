Lag3			exponential lag

Inherits from: Object : AbstractFunction : UGen : Filter : Lag


Lag3.ar(in, lagTime, mul, add)
Lag3.kr(in, lagTime, mul, add)

Lag3 is equivalent to Lag.kr(Lag.kr(Lag.kr(in, time), time), time), thus resulting in a smoother transition. This saves on CPU as you only have to calculate the decay factor once instead of three times. See Lag for more details.

See also Lag3UD

in - input signal
lagTime - 60 dB lag time in seconds.

(
// used to lag pitch
{
	SinOsc.ar(		// sine wave
		Lag3.kr(			// lag the modulator
			LFPulse.kr(4, 0, 0.5, 50, 400),	// frequency modulator
			Line.kr(0, 1, 15)				// modulate lag time
		), 
		0,	// phase
		0.3	// sine amplitude
	) 
}.play
)


