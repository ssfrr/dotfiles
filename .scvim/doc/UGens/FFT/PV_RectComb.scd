PV_RectComb			make gaps in spectrum

PV_RectComb(buffer, numTeeth,  phase,  width)

Makes a series of gaps in a spectrum.
buffer - fft buffer.
numTeeth - number of teeth in the comb.
phase - starting phase of comb pulse.
width - pulse width of comb.

See also FFT Overview.

s.boot;

(
{
	var in, chain;
	in = WhiteNoise.ar(0.2);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_RectComb(chain, 8, LFTri.kr(0.097, 0, 0.4, 0.5), 
		LFTri.kr(0.24, 0, -0.5, 0.5)); 
	IFFT(chain).dup;
}.play;
)

(
{	var in, chain;
	in = WhiteNoise.ar(0.2);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_RectComb(chain,  MouseX.kr(0, 32), MouseY.kr, 0.2); 
	IFFT(chain).dup;
}.play;
)



