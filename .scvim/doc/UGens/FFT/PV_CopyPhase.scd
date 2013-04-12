PV_CopyPhase			copy magnitudes and phases

PV_CopyPhase(bufferA,  bufferB)

Combines magnitudes of first input and phases of the second input.

bufferA - fft buffer A.
bufferB - fft buffer B.

See also FFT Overview.

s.boot;


(
SynthDef("help-copyPhase", { arg out=0;
	var inA, chainA, inB, chainB, chain;
	inA = SinOsc.ar(SinOsc.kr(SinOsc.kr(0.08, 0, 6, 6.2).squared, 0, 100, 800));	
	inB = WhiteNoise.ar(0.2);
	chainA = FFT(LocalBuf(2048), inA);
	chainB = FFT(LocalBuf(2048), inB);
	chain = PV_CopyPhase(chainA, chainB); 
	Out.ar(out, 0.5 * IFFT(chain).dup);
}).play(s,[\out, 0]);
)


d = Buffer.read(s,"sounds/a11wlk01.wav");

(
SynthDef("help-copyPhase2", { arg out=0, soundBufnum=2;
	var inA, chainA, inB, chainB, chain;
	inA = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	inB =  SinOsc.ar(SinOsc.kr(SinOsc.kr(0.08, 0, 6, 6.2).squared, 0, 100, 800));
	chainA = FFT(LocalBuf(2048), inA);
	chainB = FFT(LocalBuf(2048), inB);
	chain = PV_CopyPhase(chainA, chainB); 
	Out.ar(out,  0.5 * IFFT(chain).dup);
}).play(s,[\out, 0, \soundBufnum, d]);
)

d.free;


