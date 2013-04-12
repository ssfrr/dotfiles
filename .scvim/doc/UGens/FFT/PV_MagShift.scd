PV_MagShift				shift and stretch magnitude bin position

PV_MagShift(buffer,  stretch,  shift)

Shift and stretch the positions of only the magnitude of the bins. 
Can be used as a very crude frequency shifter/scaler.
buffer - fft buffer.
stretch - scale bin location by factor.
shift - add an offset to bin position.

See also FFT Overview.

s.boot;

(
SynthDef("help-magStretch", { arg out=0;
	var in, chain;
	in = LFSaw.ar(200, 0, 0.2);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_MagShift(chain, MouseX.kr(0.25, 4, \exponential) ); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play;
)

(
SynthDef("help-magStretch2", { arg out=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_MagShift(chain, MouseX.kr(0.25, 4, \exponential) ); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \soundBufnum, c]);
)

(
SynthDef("help-magShift", { arg out=0;
	var in, chain;
	in = LFSaw.ar(200, 0, 0.2);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_MagShift(chain, 1, MouseX.kr(-128, 128) ); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play;
)


c = Buffer.read(s,"sounds/a11wlk01.wav");

(
SynthDef("help-magShift2", {  arg out=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(LocalBuf(2048), in);
	chain = PV_MagShift(chain, 1, MouseX.kr(-128, 128) ); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \soundBufnum, c]);
)

c.free;


