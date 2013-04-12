Lag2			exponential lag

Inherits from: Object : AbstractFunction : UGen : Filter : Lag

Lag2.ar(in, lagTime, mul, add)
Lag2.kr(in, lagTime, mul, add)

Lag2 is equivalent to Lag.kr(Lag.kr(in, time), time), thus resulting in a smoother transition. This saves on CPU as you only have to calculate the decay factor once instead of twice. See Lag for more details.

See also Lag2UD

in - input signal
lagTime - 60 dB lag time in seconds.

(
// used to lag pitch
{
	SinOsc.ar(		// sine wave
		Lag2.kr(			// lag the modulator
			LFPulse.kr(4, 0, 0.5, 50, 400),	// frequency modulator
			Line.kr(0, 1, 15)				// modulate lag time
		), 
		0,	// phase
		0.3	// sine amplitude
	) 
}.play
)


