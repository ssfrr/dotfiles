PV_Add		complex addition

PV_Add(bufferA,  bufferB)

Complex Addition: RealA + RealB, ImagA + ImagB
bufferA - fft buffer A.
bufferB - fft buffer B.
See also FFT Overview.

s.boot;

d = Buffer.read(s,"sounds/a11wlk01.wav");


(
SynthDef("help-add", { arg out=0, soundBufnum;
	var inA, chainA, inB, chainB, chain ;
	inA = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	inB =  PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum) * 0.5, loop: 1);
	chainA = FFT(LocalBuf(2048), inA);
	chainB = FFT(LocalBuf(2048), inB);
	chain = PV_Add(chainA, chainB); 
	Out.ar(out,  0.1 * IFFT(chain).dup);
}).play(s, [\soundBufnum, d]);
)

d.free;


