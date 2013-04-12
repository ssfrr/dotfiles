PV_MagMul			multiply magnitudes

Inherits from: Object : AbstractFunction : UGen : PV_ChainUGen


PV_MagMul(bufferA,  bufferB)

Multiplies magnitudes of two inputs and keeps the phases of the first input.
bufferA - fft buffer A.
bufferB - fft buffer B.

See also FFT Overview.

s.boot;


(
SynthDef(\help_magMul, { arg out=0;
	var inA, chainA, inB, chainB, chain;
	inA = WhiteNoise.ar(0.2);
	inB = LFSaw.ar(100, 0, 0.2);
	chainA = FFT(LocalBuf(2048), inA);
	chainB = FFT(LocalBuf(2048), inB);
	chain = PV_MagMul(chainA, chainB); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play;
)


c = Buffer.read(s,"sounds/a11wlk01.wav");

(
SynthDef(\help_magMul, { arg out=0, soundBufnum=0;
	var inA, chainA, inB, chainB, chain;
	inA = LFSaw.ar([100, 150], 0, 0.2); // stereo signal ...
	inB = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chainA = FFT({ LocalBuf(2048) }.dup, inA); // ... needs two buffers.
	chainB = FFT(LocalBuf(2048), inB);
	chain = PV_MagMul(chainA, chainB); 
	Out.ar(out,  0.1 * IFFT(chain));
}).play(s, [\out, 0, \soundBufnum, c]);
)

c.free;


