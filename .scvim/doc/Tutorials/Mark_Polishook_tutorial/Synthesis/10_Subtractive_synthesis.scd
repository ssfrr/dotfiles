Filtering

The basic idea of subtractive synthesis is similar to making coffee: something goes through a filter to remove unwanted components from the final product.

////////////////////////////////////////////////////////////////////////////////////////////////////

The .dumpClassSubtree message

Get a list of ugen filters in SuperCollider 3, by sending the .dumpClassSubtree message to the Filter class, as in

Filter.dumpClassSubtree;

(Object.dumpClassSubtree prints all SuperCollider classes)

////////////////////////////////////////////////////////////////////////////////////////////////////

The list of Filters, as of 19.5.04, includes

[
  DetectSilence
  Formlet
  Ringz
  SOS
  FOS
  Slew
  Median
  LPZ2
    [ BRZ2 BPZ2 HPZ2 ]
  Slope
  LPZ1
    [ HPZ1 ]
  MidEQ
  BPF
    [ BRF ]
  LPF
    [ HPF ]
  RLPF
    [ RHPF ]
  LeakDC
  Lag
    [ Ramp Lag3 Lag2 ]
  Decay2
  Decay
  Integrator
  TwoPole
    [ APF TwoZero ]
  OnePole
    [ OneZero ]
  Resonz
]

Look in Help/UGens/Filters in the SuperCollider help system to see filter help files and numerous examples.

////////////////////////////////////////////////////////////////////////////////////////////////////

Use LPF, a low-pass filter to subtract high-frequency content from an input source.

(
SynthDef("subtractive", {
	Out.ar(
		0,
		LPF.ar(
			Pulse.ar(440, 0.5, 0.1),	// the source to be filtered
			Line.kr(8000, 660, 6)		// control the filter frequency with a line
		)
	)
}).load(s);
)

Synth("subtractive")
		
////////////////////////////////////////////////////////////////////////////////////////////////////

RLPF, a resonant low-pass filter, removes high-frequency content and emphasizes the cutoff frequency.

(
SynthDef("passLowFreqs2", {
	Out.ar(
		0,
		RLPF.ar(
			Saw.ar([220, 221] + LFNoise0.kr(1, 100, 200), 0.2),
			[LFNoise0.kr(4, 600, 2400), LFNoise0.kr(3, 600, 2400)],
			0.1
		)
	)
}).load(s);
)

Synth("passLowFreqs2")

////////////////////////////////////////////////////////////////////////////////////////////////////

Resonz is a very, very, very strong filter. Use it to emphasize a frequency band.

Transform noise into pitch with a sharp cutoff.

(
SynthDef("noiseToPitch", { arg out = 0, mul = 1;
	Out.ar(
		out,
		Resonz.ar(
			WhiteNoise.ar(mul),
			LFNoise0.kr(4, 110, 660),
			[0.005, 0.005]
		)
	)
}).load(s);
)

(
// activate left and right channels
Synth("noiseToPitch", [\out, 0, \mul, 1]);
Synth("noiseToPitch", [\out, 1, \mul, 1]);
)

////////////////////////////////////////////////////////////////////////////////////////////////////

go to 11_Compound_synthesis


