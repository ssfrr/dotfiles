FFT			Fast Fourier Transform

Inherits from: Object : AbstractFunction : UGen : PV_ChainUGen


FFT.new(buffer, input, hop, wintype, active, winsize)

The fast fourier transform analyzes the frequency content of a signal, which can be useful for audio analysis or for frequency-domain sound processing (phase vocoder).

buffer - The buffer where a frame will be held. Its size must be a power of two. LocalBuf is useful here, because processes should not share data between synths. (Note: most PV UGens operate on this data in place. Use PV_Copy for parallel processing.)

input - the signal to be analyzed. The signal's rate determines the rate at which the input is read.

Only the above two arguments are required. The remaining arguments allow for custom FFT analyses for specialised situations:

hop - the amount of offset from one FFT analysis frame to the next, measured in multiples of the analysis frame size. This can range between zero and one, and the default is 0.5 (meaning each frame has a 50% overlap with the preceding/following frames).
wintype - defines how the data is windowed:
	-1 is for rectangular windowing, simple but typically not recommended; 
	0 (the default) is for Sine windowing, typically recommended for phase-vocoder work; 
	1 is for Hann windowing, typically recommended for analysis work.
active - is a simple control allowing FFT analysis to be active (>0) or inactive (<=0). This is mainly useful for signal analysis processes which are only intended to analyse at specific times rather than continuously
winsize - the windowed audio frames are usually the same size as the buffer. If you wish the FFT to be zero-padded then you can specify a window size smaller than the actual buffer size (e.g. window size 1024 with buffer size 2048). Both values must still be a power of two. Leave this at its default of zero for no zero-padding.

FFT uses a local buffer for holding the buffered audio. The buffer size must be a multiple of the control block size as well as being a power of two.

Note that for phase-vocoder usage, changing the hop or wintype settings from their defaults will typically result in unnatural sound when used in combination with IFFT, due to windowing artifacts. (A hop of 0.25, with Hann windowing, can be a useful combination for phase-vocoder work.)

See also: FFT Overview, IFFT, PV_Copy






(
SynthDef("help-noopFFT", { arg out=0;
	var in, chain;
	in = WhiteNoise.ar(0.05);
	chain = FFT(LocalBuf(2048), in);
	chain.inspect; // its an FFT
	Out.ar(out, 
		IFFT(chain) // inverse FFT
	);
}).play;
)

(
SynthDef("help-sineFFT", { arg out=0;
	var in, chain;
	in = SinOsc.ar(SinOsc.kr(SinOsc.kr(0.08,0,6,6.2).squared, 0, 100,800));
	chain = FFT(LocalBuf(2048), in);
	Out.ar(out, IFFT(chain));
}).play;
)

(
SynthDef("help-magAbove", { arg out=0;
	var in, chain;
	in = SinOsc.ar(SinOsc.kr(SinOsc.kr(0.08,0,6,6.2).squared, 0, 100,800));
	//in = WhiteNoise.ar(0.2);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_MagAbove(chain, 310); 
	Out.ar(out, 0.5 * IFFT(chain));
}).play;
)

(
SynthDef("help-brick", { arg out=0;
	var in, chain;
	in = WhiteNoise.ar(0.2);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_BrickWall(chain, SinOsc.kr(0.1)); 
	Out.ar(out, IFFT(chain));
}).play;
)

(
SynthDef("help-randcomb", { arg out=0;
	var in, chain;
	in = WhiteNoise.ar(0.8);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_RandComb(chain, 0.95, Impulse.kr(0.4)); 
	Out.ar(out, IFFT(chain));
}).play;
)

(
SynthDef("help-rectcomb", { arg out=0;
	var in, chain;
	in = WhiteNoise.ar(0.2);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_RectComb(chain, 8, LFTri.kr(0.097,0,0.4,0.5), 
		LFTri.kr(0.24,0,-0.5,0.5)); 
	Out.ar(out, IFFT(chain));
}).play;
)

(
SynthDef("help-magFreeze", { arg out=0;
	var in, chain;
	in = SinOsc.ar(LFNoise1.kr(5.2,250,400));
	chain = FFT(LocalBuf(2048), in);
	// moves in and out of freeze
	chain = PV_MagFreeze(chain, SinOsc.kr(-0.2) ); 
	Out.ar(out, 0.5 * IFFT(chain));
}).play;
)


