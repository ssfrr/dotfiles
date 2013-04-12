PV_MagNoise					multiply magnitudes by noise

Inherits from: Object : AbstractFunction : UGen : PV_ChainUGen : PV_MagSquared

PV_MagNoise.new(buffer)

Magnitudes are multiplied with noise.
buffer - fft buffer.

See also FFT Overview.

s.boot;

(
SynthDef("help-magNoise", { arg out=0;
	var in, chain;
	in = SinOsc.ar(SinOsc.kr(SinOsc.kr(0.08, 0, 6, 6.2).squared, 0, 100, 800));
	chain = FFT(LocalBuf(2048), in);
	chain = PV_MagNoise(chain); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0]);
)


c = Buffer.read(s,"sounds/a11wlk01.wav");

(
SynthDef("help-magNoise2", {  arg out=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_MagNoise(chain); 
	Out.ar(out, 0.5 * IFFT(chain).dup); 
}).play(s,[\out, 0, \soundBufnum, c]);
)

c.free;


