PV_BrickWall				partially zero bins

Inherits from: Object : AbstractFunction : UGen : PV_ChainUGen


PV_BrickWall(buffer,  wipe)

Clears bins above or below a cutoff point.
buffer - fft buffer.
wipe - can range between -1 and +1.
if wipe == 0 then there is no effect.
if  wipe > 0 then it acts like a high pass filter, clearing bins from the bottom up. 
if  wipe < 0 then it acts like a low pass filter, clearing bins from the top down.

See also FFT Overview.


(
{ var in, chain;
	in = WhiteNoise.ar(0.2);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_BrickWall(chain, SinOsc.kr(0.1)); 
	IFFT(chain)
}.play;
)


