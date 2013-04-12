PV_MagFreeze				freeze magnitudes

PV_MagFreeze(buffer, freeze)

Freezes magnitudes at current levels when freeze > 0.
buffer - fft buffer.
freeze - if freeze > 0 then magnitudes are frozen at current levels.

See also FFT Overview.

s.boot;
(
b = Buffer.alloc(s,2048,1);
c = Buffer.read(s,"sounds/a11wlk01.wav");
)

(
SynthDef("help-magFreeze", { arg out=0, bufnum=0;
	var in, chain;
	in = SinOsc.ar(LFNoise1.kr(5.2,250,400));
	chain = FFT(bufnum, in);
	// moves in and out of freeze
	chain = PV_MagFreeze(chain, SinOsc.kr(0.2) ); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b]);

)

(
//trig with MouseY
SynthDef("help-magFreeze2", { arg out=0, bufnum=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(bufnum, in);
	chain = PV_MagFreeze(chain, MouseY.kr > 0.5 ); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b, \soundBufnum, c]);
)

b.free; c.free;


