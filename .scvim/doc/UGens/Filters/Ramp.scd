Ramp			linear lag

Inherits from: Object : AbstractFunction : UGen : Filter : Lag


Ramp.ar(in, lagTime, mul, add)
Ramp.kr(in, lagTime, mul, add)

This is similar to Lag but with a linear rather than exponential lag. This is useful for smoothing out control signals.

in - input signal
lagTime - 60 dB lag time in seconds.

Server.internal.boot;
(
// used to lag pitch
{
	SinOsc.ar(		// sine wave
		Ramp.kr(			// lag the modulator
			LFPulse.kr(4, 0, 0.5, 50, 400),	// frequency modulator
			Line.kr(0, 1, 15)				// modulate lag time
		), 
		0,	// phase
		0.3	// sine amplitude
	) 
}.scope;
)

// Compare
(
var pulse;
{
	pulse = LFPulse.kr(8.772);
	Out.kr(0,[Ramp.kr(pulse, 0.025), Lag.kr(pulse, 0.025), pulse]);
}.play(Server.internal);
Server.internal.scope(3, bufsize: 44100, rate: \control, zoom: 40);
)


