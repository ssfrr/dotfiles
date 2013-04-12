pvcalc		Process the bins of an FFT chain

	chain = chain.pvcalc(numframes, func, frombin, tobin, zeroothers)

pvcalc applies function func to the frequency-domain data of an FFT chain. func should be a function that takes two arrays as inputs (magnitude, and phase) and returns a resulting pair of arrays [magnitude, phase].

frombin, tobin, and zeroothers are optional arguments which limit the processing to a specified integer range of FFT bins. If zeroothers is set to 1 then bins outside of the range being processed are silenced.

See pvcollect for discussion of efficiency considerations. See also pvcalc2, UnpackFFT.


Examples

(
s.boot.doWhenBooted{
	c = Buffer.read(s,"sounds/a11wlk01.wav");
}
)

(
x = {
	var in, chain, v;
	in = PlayBuf.ar(1, c, BufRateScale.kr(c), loop: 1);
	chain = FFT(LocalBuf(1024), in);
		
	chain = chain.pvcalc(1024, {|mags, phases|
//////// Try uncommenting each of these lines in turn and re-running the synth:
		[mags * {1.5.rand}.dup(mags.size), phases + {pi.rand}.dup(phases.size)]; // Arbitrary filter, arbitrary phase shift
		//[mags.reverse, phases.reverse]; // Upside-down!
		//[mags.differentiate, phases.differentiate]; // Differentiate along frequency axis
		//[mags[30..] ++ mags[..30], phases[30..] ++ phases[..30]]; // ".rotate" doesn't work directly, but this is equivalent
	}, frombin: 0, tobin: 250, zeroothers: 0);
	
	Out.ar(0, 0.5 * IFFT(chain).dup);
}.play(s);
)
x.free;


