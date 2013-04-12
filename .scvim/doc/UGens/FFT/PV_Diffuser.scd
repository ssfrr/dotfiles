PV_Diffuser				random phase shifting

Inherits from: Object : AbstractFunction : UGen : PV_ChainUGen 

PV_Diffuser(buffer,  trig)

Adds a different constant random phase shift to each bin.
The trigger will select a new set of random phases.
buffer - fft buffer.
trig - a trigger selects a new set of random values.

See also FFT Overview.

s.boot;


(
// trig with MouseY
SynthDef("help-diffuser", { arg out=0;
	var in, chain;
	in = Mix.ar(SinOsc.ar(200 * (1..10), 0, Array.fill(10, {rrand(0.1, 0.2)}) ));
	chain = FFT(LocalBuf(2048), in);
	chain = PV_Diffuser(chain, MouseY.kr > 0.5 ); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0]);
)

d = Buffer.read(s,"sounds/a11wlk01.wav");

(
// trig with MouseY
SynthDef("help-diffuser2", { arg out=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_Diffuser(chain, MouseY.kr > 0.5 ); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \soundBufnum, d]);
)

d.free;


