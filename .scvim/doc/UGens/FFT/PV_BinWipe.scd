PV_BinWipe		combine low and high bins from two inputs

Inherits from: Object : AbstractFunction : UGen : PV_ChainUGen


PV_BinWipe(bufferA,  bufferB, wipe)

Copies low bins from one input and the high bins of the other.
bufferA - fft buffer A.
bufferB - fft buffer B.
wipe - can range between -1 and +1.
if wipe == 0 then the output is the same as inA.
if  wipe > 0 then it begins replacing with bins from inB from the bottom up. 
if  wipe < 0 then it begins replacing with bins from inB from the top down.

See also FFT Overview.

s.boot;
d = Buffer.read(s,"sounds/a11wlk01.wav");


(
SynthDef("help-binWipe", { arg out=0;
	var inA, chainA, inB, chainB, chain;
	inA = WhiteNoise.ar(0.2);
	inB = LFSaw.ar(100, 0, 0.2);
	chainA = FFT(LocalBuf(2048), inA);
	chainB = FFT(LocalBuf(2048), inB);
	chain = PV_BinWipe(chainA, chainB, MouseX.kr(-1, 1)); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0]);
)

(
SynthDef("help-binWipe2", { arg out=0, soundBufnum=2;
	var inA, chainA, inB, chainB, chain;
	inA = WhiteNoise.ar(0.2);
	inB = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chainA = FFT(LocalBuf(2048), inA);
	chainB = FFT(LocalBuf(2048), inB);
	chain = PV_BinWipe(chainA, chainB, MouseX.kr(-1, 1)); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \soundBufnum, d]);
)

d.free;


