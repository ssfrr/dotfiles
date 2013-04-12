PV_MagSquared					square magnitudes

PV_MagSquared(buffer)

Squares the magnitudes and renormalizes to previous peak. This makes weak bins weaker.
buffer - fft buffer.

See also FFT Overview.

s.boot;
c = Buffer.read(s,"sounds/a11wlk01.wav");


(
SynthDef("help-magSquared", {  arg out=0, bufnum=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_MagSquared(chain); 
	Out.ar(out, 0.003 * IFFT(chain).dup); 
}).play(s,[\out, 0, \soundBufnum, c]);
)

c.free;


