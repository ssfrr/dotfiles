Lag3UD			exponential lag

Lag3UD.ar(in, lagTimeU, lagTimeD, mul, add))
Lag3UD.kr(in, lagTimeU, lagTimeD, mul, add))


Lag3UD is equivalent to LagUD.kr(LagUD.kr(LagUD.kr(in, timeU, timeD), timeU, timeD), timeU, timeD), thus resulting in a smoother transition. This saves on CPU as you only have to calculate the decay factor once instead of three times. See LagUD for more details.

See also Lag3
in - input signal
lagTimeU - 60 dB lag time in seconds for the upgoing signal.
lagTimeD - 60 dB lag time in seconds for the downgoing signal.

(
// used to lag pitch
       SynthDef( \lag3ud_help,
      
	{ arg freq=300,lagup=1, lagdown=5;
		Out.ar( 0,
			SinOsc.ar( // sine wave
				Lag3UD.kr( // lag the frequency
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

x = Synth.new( \lag3ud_help ); // create the synth
      
x.set( \freq, 500 ); // set the frequency to a higher value (takes 1 second)
x.set( \freq, 100 ); // set the frequency to a lower value (takes 5 seconds)
x.free;


