Lag2UD			exponential lag

Inherits from: Object : AbstractFunction : UGen : Filter : Lag


Lag2UD.ar(in, lagTimeU, lagTimeD, mul, add))
Lag2UD.kr(in, lagTimeU, lagTimeD, mul, add))

Lag2 is equivalent to Lag.kr(Lag.kr(in, time), time), thus resulting in a smoother transition. This saves on CPU as you only have to calculate the decay factor once instead of twice. See Lag for more details.

See also Lag2
in - input signal
lagTimeU - 60 dB lag time in seconds for the upgoing signal.
lagTimeD - 60 dB lag time in seconds for the downgoing signal.

(
// used to lag pitch
       SynthDef( \lag2ud_help,
      
	{ arg freq=300,lagup=1, lagdown=5;
		Out.ar( 0,
			SinOsc.ar( // sine wave
				Lag2UD.kr( // lag the frequency
					freq,
					lagup,
					lagdown
				),
				0, // phase
				0.2 // sine amplitude
			)
		);
	}).send(s);
)

x = Synth.new( \lag2ud_help ); // create the synth
      
x.set( \freq, 500 ); // set the frequency to a higher value (takes 1 second)
x.set( \freq, 100 ); // set the frequency to a lower value (takes 5 seconds)
x.free;


