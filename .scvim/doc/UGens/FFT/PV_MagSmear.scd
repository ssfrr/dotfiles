PV_MagSmear				average magnitudes across bins

PV_MagSmear(buffer,  bins)

Average a bin's magnitude with its neighbors. 
buffer - fft buffer.
bins - number of bins to average on each side of bin. As this number rises, so will CPU usage.

See also FFT Overview.

s.boot;


(
SynthDef("help-magSmear", { arg out=0;
	var in, chain;
	in = LFSaw.ar(500, 0, Decay2.ar(Impulse.ar(2,0,0.2), 0.01, 2));
	chain = FFT(LocalBuf(2048), in);
	chain = PV_MagSmear(chain, MouseX.kr(0, 100)); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play;
)

c = Buffer.read(s,"sounds/a11wlk01.wav");


(
SynthDef("help-magSmear2", { arg out=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_MagSmear(chain, MouseX.kr(0, 100)); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \soundBufnum, c]);
)

c.free;


