PV_MagClip				clip bins to a threshold

PV_MagClip(buffer,  threshold)

Clips bin magnitudes to a maximum threshold.
buffer - fft buffer.
threshold - magnitude threshold.

See also FFT Overview.

s.boot;
(
b = Buffer.alloc(s,2048,1);
c = Buffer.read(s,"sounds/a11wlk01.wav");
)

(
SynthDef("help-magClip", { arg out=0, bufnum=0;
	var in, chain;
	in = Mix.arFill(3, { LFSaw.ar(exprand(100, 500), 0, 0.1); });
	chain = FFT(bufnum, in);
	chain = PV_MagClip(chain, MouseX.kr(0, 15)); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b]);
)

(
SynthDef("help-magClip2", { arg out=0, bufnum=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(bufnum, in);
	chain = PV_MagClip(chain, MouseX.kr(0, 50)); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b, \soundBufnum, c]);
)

b.free; c.free;


