PV_LocalMax			pass bins which are a local maximum

Inherits from: Object : AbstractFunction : UGen : PV_ChainUGen 

PV_LocalMax(buffer,  threshold)

Passes only bins whose magnitude is above a threshold and above their nearest neighbors.
buffer - fft buffer.
threshold - magnitude threshold.

See also FFT Overview.

s.boot;


(
SynthDef("help-localMax", { arg out=0;
	var in, chain;
	in = Mix.arFill(3, { LFSaw.ar(exprand(100, 500), 0, 0.1); });
	chain = FFT(LocalBuf(2048), in);
	chain = PV_LocalMax(chain, MouseX.kr(0, 50)); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0]);
)

d = Buffer.read(s,"sounds/a11wlk01.wav");

(
SynthDef("help-localMax2", { arg out=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_LocalMax(chain, MouseX.kr(0, 100)); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \soundBufnum, d]);
)

d.free;



