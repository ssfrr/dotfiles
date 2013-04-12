PV_MagAbove				pass bins above a threshold

PV_MagAbove(buffer, threshold)

Passes only bins whose magnitude is above a threshold.
buffer - fft buffer.
threshold - magnitude threshold.

See also FFT Overview.

s.boot;

(
SynthDef("help-magAbove", { arg out=0;
	var in, chain;
	in = SinOsc.ar(SinOsc.kr(SinOsc.kr(0.08, 0, 6, 6.2).squared, 0, 100, 800));
	//in = WhiteNoise.ar(0.2);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_MagAbove(chain, 310); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play;
)


(
SynthDef("help-magAbove2", { arg out=0;
	var in, chain;
	in = WhiteNoise.ar(0.2);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_MagAbove(chain, MouseX.kr(0, 10)); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play;
)


c = Buffer.read(s,"sounds/a11wlk01.wav");

(
SynthDef("help-magAbove3", { arg out=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_MagAbove(chain, MouseX.kr(0, 310)); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \soundBufnum, c]);
)

c.free;


