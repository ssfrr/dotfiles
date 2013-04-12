pvcalc2		Process the bins of two FFT chains

	chain = chain.pvcalc2(chain2, numframes, func, frombin, tobin, zeroothers)

pvcalc2 is just like pvcalc but can combine two FFT chains together. See pvcalc for more information.

func should be a function that takes four arrays as inputs (magnitudes1, phases1, magnitudes2, phases2) and returns a resulting pair of arrays [magnitude, phase].


Example

(
s.boot.doWhenBooted {
c = Buffer.read(s,"sounds/a11wlk01.wav");
}
)

(
x = {
	var fftsize = 1024;
	var in, chain, in2, chain2, out;
	in = PlayBuf.ar(1, c, BufRateScale.kr(c), loop: 1);
	chain = FFT(LocalBuf(fftsize), in);
		
	// in2 = PlayBuf.ar(1, e, BufRateScale.kr(e), loop: 1);
	// JMcC babbling brook
	in2 = ({
		RHPF.ar(OnePole.ar(BrownNoise.ar, 0.99), LPF.ar(BrownNoise.ar, 14)
			* 400 + 500, 0.03, 0.003)}!2)
			+ ({RHPF.ar(OnePole.ar(BrownNoise.ar, 0.99), LPF.ar(BrownNoise.ar, 20)
			* 800 + 1000, 0.03, 0.005)}!2
		)
			* 4;
	chain2 = FFT(LocalBuf(fftsize), in2);
	
	chain = chain.pvcalc2(chain2, fftsize, {|mags, phases, mags2, phases2|
		[mags * mags2 / 10, phases2 + phases]
	}, frombin: 0, tobin: 125, zeroothers: 0);
	
	out = IFFT(chain);
	Out.ar(0, 0.5 * out.dup);
}.play(s);
)
x.free;


