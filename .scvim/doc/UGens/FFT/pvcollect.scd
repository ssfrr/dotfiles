pvcollect		Process each bin of an FFT chain, separately

	chain = chain.pvcollect(numframes, func, frombin, tobin, zeroothers)

pvcollect applies function func to each bin of an FFT chain. func should be a function that takes magnitude, phase, index as inputs and returns a resulting [magnitude, phase].

The "index" is the integer bin number, starting at 0 for DC. You can optionally ignore the phase and only return a single (magnitude) value, in which case the phase is assumed to be left unchanged.

frombin, tobin, and zeroothers are optional arguments which limit the processing to a specified integer range of FFT bins. If zeroothers is set to 1 then bins outside of the range being processed are silenced.

Note that this procedure can be relatively CPU-heavy, depending on how you use it. See "efficiency considerations" below. 

See also: pvcalc, pvcalc2, UnpackFFT.


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
	
	v = LFPar.kr(0.5).range(0.1, 1);
	
	chain = chain.pvcollect(1024, {|mag, phase, index|
//////// Try uncommenting each of these lines in turn and re-running the synth:
		//mag;
		//[mag, phase];
		//[mag, phase] / 3;
		//[mag, phase].sqrt;
		//[mag, 3.14.rand];
		//[mag, LFNoise0.kr.range(0, 3.14)];
		//[mag * Dseq([1, 0, 0, 1, 1, 0, 1, 0].stutter(8), 999999999999)]; // Can even use Demand ugens! One val demanded each frame
		//[mag.sqrt, 3.14.rand];
		//if(index % 7 == 0, mag, 0); // Comb filter
		//if(LFNoise0.kr(10) > 0.5, mag, 0);
		//mag + DelayN.kr(mag, 1, v); // Spectral delay
		if((index-LFPar.kr(0.1).range(2, 1024/20)).abs < 10, mag, 0); // Swept bandpass
	}, frombin: 0, tobin: 250, zeroothers: 0);
	
	Out.ar(0, 0.5 * IFFT(chain).dup);
}.play(s);
)
x.free;


Efficiency considerations

Using pvcollect (or its components, UnpackFFT & PackFFT) is usually less efficient than using a single "PV_" unit generator to process an FFT chain, because it involves the creation of quite a large graph of demand-rate unit generators.

If you wish to reduce the CPU impact of using this approach, try the following:


Use the frombin and tobin arguments to limit the number of FFT bins that will be included in the calculation. Often the lower FFT bins contain the loudest and/or most relevant information, so perhaps your effect sounds very similar if you ignore the higher-up bins (either leave them unprocessed, or discard them by setting the zeroothers argument to 1, which has the effect of a band-pass frequency-domain filter).
Use a smaller FFT buffer size.
Avoid creating ugens inside your calculation function if at all possible. For example, a deterministic ugen such as LFPar.kr(0.5, 0, 1) will be replicated once for each bin if specified inside the function, despite the fact that the output is always the same. Define it outside the calculation function and then reference it by variable name.
Avoid unused calculations! For example, uncommenting all the different lines in the above will waste effort because many values will be calculated but not used. This cannot be optimised away during compilation. It is particularly important because all calculations are duplicated (once for each bin) so can have a significant impact on efficiency.
If you find yourself calling pvcollect on an FFT chain more than once in series, you should definitely try to combine your processing into a single pvcollect function, to avoid unneccessary unpacking-then-packing-then-unpacking-then-packing.



