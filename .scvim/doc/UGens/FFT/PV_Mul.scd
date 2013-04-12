PV_Mul			complex multiply

PV_Mul(bufferA,  bufferB)

Complex Multiplication: (RealA * RealB) - (ImagA * ImagB), (ImagA * RealB) + (RealA * ImagB)
bufferA - fft buffer A.
bufferB - fft buffer B.

See also FFT Overview.



(
{
	var inA, chainA, inB, chainB, chain ;
	inA = Saw.ar(LFNoise1.kr(2).exprange(10, 1000));
	inB =  Pulse.ar(LFNoise1.kr(2).exprange(10, 1000));
	chainA = FFT(LocalBuf(2048), inA);
	chainB = FFT(LocalBuf(2048), inB);
	chain = PV_Mul(chainA, chainB); 
	0.03 * IFFT(chain).dup;
}.play
);


// stereo version:

(
{
	var inA, chainA, inB, chainB, chain ;
	inA = Saw.ar(LFNoise1.kr(2).exprange(10, 1000)); // same saw through different pulses
	inB =  Pulse.ar(LFNoise1.kr(2.dup).exprange(10, 1000));
	chainA = FFT(LocalBuf(2048.dup), inA);
	chainB = FFT(LocalBuf(2048.dup), inB);
	chain = PV_Mul(chainA, chainB); 
	0.03 * IFFT(chain);
}.play
);



(
SynthDef("help-mul", { arg out=0;
	var inA, chainA, inB, chainB, chain ;
	inA = SinOsc.ar(500, 0, 0.5);
	inB =  SinOsc.ar(Line.kr(100, 400, 5), 0, 0.5);
	chainA = FFT(LocalBuf(2048), inA);
	chainB = FFT(LocalBuf(2048), inB);
	chain = PV_Mul(chainA, chainB); 
	Out.ar(out,  0.5 * IFFT(chain).dup);
}).play;
)

(
SynthDef("help-mul2", { arg out=0;
	var inA, chainA, inB, chainB, chain ;
	inA = SinOsc.ar(500, 0, 0.5) * Line.kr;
	inB = LFNoise1.ar(20);
	chainA = FFT(LocalBuf(2048), inA);
	chainB = FFT(LocalBuf(2048), inB);
	chain = PV_Mul(chainA, chainB); 
	Out.ar(out,  0.5 * IFFT(chain).dup);
}).play;
)



