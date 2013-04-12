PV_BinScramble				scramble bins

PV_BinScramble(buffer,  wipe,  width,  trig)

Randomizes the order of the bins.
The trigger will select a new random ordering.
buffer - fft buffer.
wipe - scrambles more bins as wipe moves from zero to one.
width - a value from zero to one, indicating the maximum randomized distance of a bin from its
original location in the spectrum.
trig - a trigger selects a new random ordering.

See also FFT Overview.

s.boot;

c = Buffer.read(s,"sounds/a11wlk01.wav");


(
// trig with MouseY
SynthDef("help-binScramble", { arg out=0, bufnum=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_BinScramble(chain, MouseX.kr , 0.1, MouseY.kr > 0.5 ); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b, \soundBufnum, c]);
)

c.free;


