IFFT			Inverse Fast Fourier Transform

Inherits from: Object : AbstractFunction : UGen 


IFFT.new(chain, wintype, winsize)
IFFT.ar(chain, wintype, winsize)
IFFT.kr(chain, wintype, winsize)


The fast fourier transform analyzes the frequency content of a signal. The IFFT UGen converts this frequency-domain information back into time-domain audio data. Most often this is used as the end of a process which begins with FFT, followed by frequency-domain processing using PV (phase-vocoder) UGens, followed by IFFT.

chain - The FFT "chain" signal coming originally from an FFT UGen, perhaps via other PV UGens.
wintype - defines how the data is windowed:
	-1 is for rectangular windowing, simple but typically not recommended; 
	0 (the default) is for Sine windowing, typically recommended for phase-vocoder work; 
	1 is for Hann windowing, typically recommended for analysis work.
winsize - can be used to account for zero-padding, in the same way as the FFT UGen.

The IFFT UGen converts the FFT data in-place (in the original FFT buffer) and overlap-adds the result to produce a continuous signal at its output.

See also: FFT Overview, FFT, PV_Copy



// example
(
{ var in, chain;
	in = WhiteNoise.ar(0.05);
	chain = FFT(LocalBuf(2048), in);
	chain.inspect; // its an FFT
	Out.ar(0, 
		IFFT(chain) // inverse FFT
	);
}.play
)

See FFT for more examples.



