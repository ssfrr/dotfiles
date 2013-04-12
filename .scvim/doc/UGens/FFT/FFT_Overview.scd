FFT Overview

FFT and IFFT

SuperCollider implements a number of UGens supporting FFT based processing. The most basic of these are FFT and IFFT which convert data between the time and frequency domains:

	FFT(buffer, input)
	IFFT(buffer)

FFT stores spectral data in a local buffer (see Buffer) in the following order: DC, nyquist, real 1f, imag 1f, real 2f, imag 2f, ... real (N-1)f, imag (N-1)f, where f is the frequency corresponding to the window size, and N is the window size / 2.

The buffer's size must correspond to a power of 2, and must also be a multiple of SC's block size. The window size is equivalent to the buffer size, and the window overlap defaults to 2. Both FFT and IFFT use a Sine window by default, the combination of which (i.e. raised sine, that is, sine squared) is a Hanning window.

Phase Vocoder UGens and Spectral Processing

In between an FFT and an IFFT one can chain together a number of Phase Vocoder UGens (i.e. 'PV_...') to manipulate blocks of spectral data before reconversion. The process of buffering the appropriate amount of audio, windowing, conversion, overlap-add, etc. is handled for you automatically.

	
	(
	{ var in, chain;
		in = WhiteNoise.ar(0.8);
		chain = FFT(LocalBuf(2048), in);
		chain = PV_RandComb(chain, 0.95, Impulse.kr(0.4)); 
		IFFT(chain);
	}.play(s);
	)

PV Ugens write their output data in place, i.e. back into the same buffer from which they read. PV UGens which require two buffers write their data into the first buffer, usually called 'bufferA'.

	
	d = Buffer.read(s,"sounds/a11wlk01.wav");
	
	
	(
	{ var inA, chainA, inB, chainB, chain;
		inA = LFSaw.ar([100, 150], 0, 0.2);
		inB = PlayBuf.ar(1, d, BufRateScale.kr(d), loop: 1);
		chainA = FFT(LocalBuf(2048), inA);
		chainB = FFT(LocalBuf(2048), inB);
		chain = PV_MagMul(chainA, chainB); // writes into bufferA
		0.1 * IFFT(chain);
	}.play(s);
	)
	
	d.free;

Because each PV UGen overwrites the output of the previous one, it is necessary to copy the data to an additional buffer at the desired point in the chain in order to do parallel processing of input without using multiple FFT UGens. PV_Copy allows for this.

	(
	b = Buffer.alloc(s,2048,1); // use global buffers for plotting the data
	c = Buffer.alloc(s,2048,1);
	)
	
	//// proof of concept
	(
	x = { var inA, chainA, chainB;
		inA = LFClipNoise.ar(100);
		chainA = FFT(b, inA);
		chainB = PV_Copy(chainA, c);  
		IFFT(chainA) - IFFT(chainB); // cancels to zero so silent!
	}.play(s);
	)
	x.free;
	// IFFTed frames contain the same windowed output data
	b.plot(\b, Rect(200, 430, 700, 300), nil, nil); c.plot(\c, Rect(200, 100, 700, 300), nil, nil);
	[b, c].do(_.free);

Note that PV UGens convert as needed between cartesian (complex) and polar representations, therefore when using multiple PV UGens it may be impossible to know in which form the values will be at any given time. FFT produces complex output (see above), so while the following produces a reliable magnitude plot:

	b = Buffer.alloc(s,1024); // use global buffers for plotting the data
	a = { FFT(b, LFSaw.ar(4000)); 0.0 }.play;
	(
	b.getn(0, 1024, { arg buf;
		var z, x;
		z = buf.clump(2).flop;
		z = [Signal.newFrom(z[0]), Signal.newFrom(z[1])];
		x = Complex(z[0], z[1]);
		{x.magnitude.plot}.defer
	})
	)
	a.free; b.free;

any Synth using PV UGens might not.

It is possible to manipulate the FFT data directly within a synth graph (if there doesn't already exist a PV UGen which will do what you want), using the methods pvcalc, pvcalc2, pvcollect. Here's an example which uses the SequenceableCollection methods clump and flop to rearrange the order of the spectral bins:

	c = Buffer.read(s,"sounds/a11wlk01.wav");
	
	(
	x = {
	  var in, numFrames=2048, chain, v;
	  in = PlayBuf.ar(1, c, loop: 1);
	  chain = FFT(LocalBuf(numFrames), in);
	 	
	  chain = chain.pvcalc(numFrames, {|mags, phases|
	      /* Play with the mags and phases, then return them */
	      [mags, phases].flop.clump(2).flop.flatten
	  }, tobin: 250);
	 
	  Out.ar(0, 0.5 * IFFT(chain).dup);
	}.play(s);
	)
	x.free; c.free;


Multichannel Expansion with FFT UGens

Care must be taken when using multichannel expansion with FFT UGens, as they require separate buffers. Code such as this can be deceptive:

chain = FFT(bufnum, {WhiteNoise.ar(0.2)}.dup);

The above may seem to work, but does not. It does result in two FFT UGens, but as they both write to the same buffer, the second simply overwrites the data from the first, thus wasting CPU and accomplishing nothing.

When using multichannel expansion with FFT UGens it is necessary to ensure that each one writes to a different buffer. Here's an example of one way to do this:




(
SynthDef("help-multichannel FFT", { arg out=0; // bufnum is an array
	var in, chain;
	in = [SinOsc.ar(200, 0, 0.2), WhiteNoise.ar(0.2)];
	chain = FFT(LocalBuf([2048, 2048]), in); // each FFT has a different buffer
	// now we can multichannel expand as normal
	chain = PV_BrickWall(chain, SinOsc.kr(-0.1));
	Out.ar(out, IFFT(chain));
}).play;
)

// or using global buffers

b = {Buffer.alloc(s,2048,1)}.dup;

(
SynthDef("help-multichannel FFT", { arg out=0, bufnum= #[0, 1]; // bufnum is an array
	var in, chain;
	in = [SinOsc.ar(200, 0, 0.2), WhiteNoise.ar(0.2)];
	chain = FFT(bufnum, in); // each FFT has a different buffer
	// now we can multichannel expand as normal
	chain = PV_BrickWall(chain, SinOsc.kr(-0.1));
	Out.ar(out, IFFT(chain));
}).play(s,[\bufnum, b]);
)



Note that dup on a UGen just makes a reference to that UGen, because UGen defines -copy to simply return the receiver. (See UGen for more detail.)

a = SinOsc.ar;
a.dup[1] === a

true

Code like IFFT(chain).dup is found throughout the PV help files , and is just a convenient way to copy a mono signal to stereo, without further computation.

See also MultiChannel.

PV and FFT UGens in the Standard Library

The following PV UGens are included in the standard SC distribution:

	FFT	Fast Fourier Transform
	IFFT	Inverse Fast Fourier Transform
	PV_Add	complex addition
	PV_BinScramble	scramble bins
	PV_BinShift	shift and stretch bin position
	PV_BinWipe	combine low and high bins from two inputs
	PV_BrickWall	zero bins
	PV_ConformalMap	complex plane attack 
	PV_Copy	copy an FFT buffer
	PV_CopyPhase	copy magnitudes and phases
	PV_Diffuser	random phase shifting
	PV_HainsworthFoote
	PV_JensenAndersen
	PV_LocalMax	pass bins which are a local maximum
	PV_MagAbove	pass bins above a threshold
	PV_MagBelow	pass bins below a threshold
	PV_MagClip	clip bins to a threshold
	PV_MagFreeze	freeze magnitudes
	PV_MagMul	multiply magnitudes
	PV_MagDiv	division of magnitudes
	PV_MagNoise	multiply magnitudes by noise
	PV_MagShift	shift and stretch magnitude bin position
	PV_MagSmear	average magnitudes across bins
	PV_MagSquared	square magnitudes
	PV_Max	maximum magnitude
	PV_Min	minimum magnitude
	PV_Mul	complex multiply
	PV_PhaseShift	shift phase of all bins
	PV_PhaseShift270	shift phase by 270 degrees
	PV_PhaseShift90	shift phase by 90 degrees
	PV_RandComb	pass random bins
	PV_RandWipe	crossfade in random bin order
	PV_RectComb	make gaps in spectrum
	PV_RectComb2	make gaps in spectrum
	UnpackFFT, PackFFT, Unpack1FFT		"unpacking" components used in pvcalc, pvcalc2, pvcollect (can also be used on their own)



